#!/usr/bin/env node

// Examples of usage:
// stooge -i tests/fixtures/fixture.yaml -o tests/tmp/yaml-to.json -f json

import yargs from "yargs";
import { hideBin } from "yargs/helpers";

import {
  SUPPORTED_EXTENSIONS,
  SUPPORTED_EXTENSIONS_LIST,
} from "#root/supported.js";
import { performConversion } from "#root/conversion.js";

const argv = yargs(hideBin(process.argv))
  .usage("Usage: stooge --input <input> --output <output> --format <format>")
  .option("input", {
    alias: ["i", "input"],
    describe: "Path to the single or multiple input files to be converted.",
    type: "string",
  })
  .option("output", {
    alias: ["o", "output"],
    describe:
      "Path to the output file or folder for saving the converted content.",
    type: "string",
  })
  .option("format", {
    alias: ["f", "format"],
    choices: SUPPORTED_EXTENSIONS,
    coerce: (value) => value.toLowerCase(),
    default: "yml",
    describe: `Format settings of the output file, supported formats: ${SUPPORTED_EXTENSIONS_LIST}.`,
    type: "string",
  }).argv;

const { input, output, format } = argv;
await performConversion(input, output, format);

process.exit(0);
