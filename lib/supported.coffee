import { extname } from "node:path"

FORMATS = [
  # Current formats:
  "ini"
  "json"
  ["yaml", "yml"]

  # Future formats:
  # "cson"
  # "csv"
  # "ical"
  # "icalendar"
  # "ics"
  # "json-ld"
  # "json5"
  # "jsonc"
  # "jsonl"
  # "jsonnet"
  # "opml"
  # "toml"
  # "vcard"
  # "vcf"
  # "xml"
]

export SUPPORTED_EXTENSIONS = FORMATS.flat()
export SUPPORTED_EXTENSIONS_LIST = SUPPORTED_EXTENSIONS.join(",")

export getFileFormatFromFilePath = (filePath = "") ->
  selectedFormat = ""
  extension = extname(filePath)?.replace(".", "").toLowerCase()

  if extension.isEmpty()
    throw new Error "File #{filePath} does not have an extension."

  if SUPPORTED_EXTENSIONS.excludes extension
    throw new Error "File #{filePath} has an unsupported extension."

  for format in FORMATS
    if format.isArray() and format.includes extension
      selectedFormat = format[0]
      break

    if format is extension
      selectedFormat = format
      break

  if selectedFormat.isEmpty()
    throw new Error "File #{filePath} has an unknown extension."

  selectedFormat
