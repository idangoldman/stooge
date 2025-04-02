export default replacer = (key, value) ->
  if typeof value is "string"
    numberValue = Number value

    return numberValue unless Number.isNaN numberValue

  value
