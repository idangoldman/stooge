import { read, write, extension } from "#root/contents.js"
import { getFileFormatFromFilePath } from "#root/supported.js"
import { safeCallback } from "#root/safe-execution.js"


export dump = (contents = {}, format = "") ->
  { stringify } = await import("#root/formats/#{format}.js")
  await stringify contents


export dumpFile = (filePath = "", contents = {}, format = "") ->
  formattedContent = await dump contents, format
  await write filePath, formattedContent


export load = (contents = "", format = "") ->
  { parse } = await import("#root/formats/#{format}.js")
  await parse contents


export loadFile = (filePath = "", format = "") ->
  format = getFileFormatFromFilePath filePath
  fileContent = await read filePath
  await load fileContent, format


export convert = (contents = "", fromFormat = "", toFormat = "") ->
  parsedContent = await load contents, fromFormat
  await dump parsedContent, toFormat


export convertFile = (filePath = "", fromFormat = "", toFormat = "") ->
  fileContent = await loadFile filePath, fromFormat
  await dumpFile filePath, fileContent, toFormat


export execute = (inputFile = "", outputFile = "", format = "yaml") ->
  fromFormat = extensionToFormat inputFile
  toFormat = extensionToFormat format, outputFile

  outputFilePath = if outputFile.length > 0
                     outputFile
                   else
                     inputFile.replace new RegExp("\\.#{fromFormat}$", "i"), ".#{toFormat}"

  contents = await loadFile inputFile
  await dumpFile outputFilePath, contents, toFormat
