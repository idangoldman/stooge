import { access, constants, readFile, writeFile } from 'node:fs/promises';
import path from 'node:path';

import { safeCallback } from '#root/library/safe-execution.js';
import { getFileFormatFromFilePath } from '#root/library/supported.js';

export async function readContent(filePath = '') {
  const absoluteFilePath = path.resolve(filePath);

  const [ error, result ] = await safeCallback(async () => {
    await access(absoluteFilePath, constants.F_OK | constants.R_OK);
    const readContent = await readFile(absoluteFilePath, 'utf-8');
    return await parseContentToObject(absoluteFilePath, readContent)
  });

  if (error) {
    throw new Error(error);
  }

  return result;
}

export async function writeContent(filePath = '', contentObject = {}) {
  const absoluteFilePath = path.resolve(filePath);

  const [ error, result ] = await safeCallback(async () => {
    const stringifiedContent = await parseObjectToContent(absoluteFilePath, contentObject);
    return await writeFile(absoluteFilePath, stringifiedContent, { encoding: 'utf-8', flag: 'w' });
  });

  if (error) {
    throw new Error(error);
  }

  return result;
}

async function parseContentToObject(filePath = '', content = '') {
  const format = getFileFormatFromFilePath(filePath);
  const { parse } = await import(`#root/formats/${format}.js`);
  return parse(content);
}

async function parseObjectToContent(filePath = '', contentObject = {}) {
  const format = getFileFormatFromFilePath(filePath);
  const { stringify } = await import(`#root/formats/${format}.js`);
  return stringify(contentObject);
}
