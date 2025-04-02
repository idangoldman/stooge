import yaml from "yaml"
import replacer from "#root/replacer.js"

export parse = (content) ->
  yaml.parse content

export stringify = (content) ->
  yaml.stringify content, replacer
