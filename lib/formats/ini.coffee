import ini from "ini"

export parse = (content) ->
  ini.parse content

export stringify = (content) ->
  options =
    bracketedArray: true
    newline: "\n"
    sort: false
    whitespace: true

  ini.stringify content, options
