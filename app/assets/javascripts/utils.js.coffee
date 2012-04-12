window.ShuffUtils =
  truncate: (str, len) ->
    if str.length > len
      return str.slice(0, len) + "..."
    else
      return str

  replaceURLs: (text, len) ->
    return if text == null
    if typeof(len) == "undefined"
      len = 35

    console.log(len)

    # http://stackoverflow.com/a/37687/604093
    exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig
    link = text.replace(exp, (match, $1) -> '<a href="' + $1 + '" target="_blank">' + ShuffUtils.truncate($1, len) + '</a>')
    return link

