window.ShuffClock =
  currentTime: (offset) ->
    currentTime = new Date()
    minutes = currentTime.getMinutes()
    hours = currentTime.getHours()
    hours += Math.floor(offset / 60) if offset
    minutes += offset % 60 if offset
    hours += 1 if minutes >= 60
    minutes -= 60 if minutes >= 60
    minutes = "0" + minutes if (minutes < 10)
    hours = hours % 12
    return hours + ":" + minutes

  displayTime: (seconds) ->
    out = ""

    if seconds < 0
      seconds = -1*seconds
      out += "-"

    out += Math.floor(seconds / 60)
    out += "m "
    if (seconds % 60 < 10)
      out += "0"

    out += seconds % 60
    out += "s"
    return out

  reset: () ->
    $('#timer-start').text(@currentTime())

  updateEndTime: (offset) ->
    $('#timer-end').text(@currentTime(offset))

  renderTimer: (initialTime) ->
    $('#rotatescroll').tinycircleslider({
      interval: true,
      intervaltime: 1000,
      radius: 70,
      hidedots: false,
      start: initialTime
    })
    this.reset()
    #$('#rotatescroll').gotoSlide(initialTime)

