import toml from "toml"

export parse = (content) ->
  toml.parse content

export stringify = (content) ->
  toml.stringify content
