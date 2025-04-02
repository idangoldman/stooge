import replacer from "#root/replacer.js"

export parse = (content) ->
  JSON.parse content

export stringify = (content) ->
  JSON.stringify(content, replacer, 2) + "\n"
