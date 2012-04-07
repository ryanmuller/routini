window.ShuffUtils =
  replaceURLs: (text) ->
    return if text == null
    # http://stackoverflow.com/a/37687/604093
    exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig
    return text.replace(exp,"<a href='$1'>$1</a>")

