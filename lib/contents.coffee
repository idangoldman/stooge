import { access, constants, readFile, writeFile } from "node:fs/promises"
import { resolve, extname } from "node:path"

import { safeCallback } from "#root/safe-execution.js"
import { SUPPORTED_EXTENSIONS } from "#root/supported.js"

export read = (filePath = "") ->
  [error, result] = await safeCallback ->
    absoluteFilePath = resolve filePath

    await access absoluteFilePath, constants.F_OK | constants.R_OK
    await readFile absoluteFilePath, "utf-8"

  throw new Error(error) if error

  result

export write = (filePath = "", contents = "") ->
  [error, result] = await safeCallback ->
    absoluteFilePath = resolve filePath

    await writeFile absoluteFilePath, contents,
      encoding: "utf-8"
      flag: "w"

  throw new Error(error) if error

  result

export extension = (filePath = "") ->
  fileExtension = extname filePath
                    .replace ".", ""
                    .toLowerCase()

  unless SUPPORTED_EXTENSIONS.includes fileExtension
    throw new Error "File \"#{filePath}\" has an unsupported extension."

  fileExtension
