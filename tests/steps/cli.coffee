import { $ } from "zx"
import { BeforeAll, Given, When, Then } from "@cucumber/cucumber"
import { readFileSync } from "fs"
import { rimrafSync } from "rimraf"
import assert from "node:assert"

import { SUPPORTED_EXTENSIONS_LIST } from "#root/supported.js"

BeforeAll ->
  rimrafSync "tmp/*.{#{SUPPORTED_EXTENSIONS_LIST}}", glob: true

Given "Stooge command prefix with {string}", (commandPrefix) ->
  $.prefix = commandPrefix + " "

Given "Fixture file in {string} format", (fromFormat) ->
  @fromFormat = fromFormat.toLowerCase()
  @fixturePath = "tests/fixtures/fixture.#{fromFormat}"

When "Convert the fixture file to {string} format", (toFormat) ->
  @toFormat = toFormat.toLowerCase()
  @outputPath = "tmp/#{@fromFormat}-to.#{@toFormat}"

  command = await $"stooge --input=\"#{@fixturePath}\" --output=\"#{@outputPath}\" --format=\"#{@toFormat}\""

  assert.equal command.exitCode, 0

Then "Converted file should match the fixture file in {string} format", (toFormat) ->
  convertedFile = readFileSync @outputPath, "utf8"
  fixtureFile = readFileSync "tests/fixtures/fixture.#{toFormat.toLowerCase()}", "utf8"

  assert.equal convertedFile, fixtureFile
