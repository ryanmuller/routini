# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  plotLogs()

  $('.action-cb').change(() ->

    if $(this).is(':checked') 
      $(this).next().css('text-decoration', 'line-through')
      $(this).next().next().attr('value', 'complete')
    else
      $(this).next().css('text-decoration', 'none')
      $(this).next().next().attr('value', 'incomplete')

    $(this).parent().submit()
  )

  $('#pause').click(() ->
    if $('#timer').data('pause') == 'true'
      $('#timer').data('pause','false')
      $('#pause > img').attr('src', '/assets/pause.png')
    else
      $('#timer').data('pause','true')
      $('#pause > img').attr('src', '/assets/play.png')
  )

  $('#reset').click(() ->
    $('#beep').removeClass('beeped')
    $('#timer').text(formatTime($('#timer').data('maxtime')))
  )



formatTime = (time) ->
  out = ""
  out += Math.floor(time/60)
  out += ":"
  out += "0" if time % 60 < 10
  out += time % 60
  return out

getSeconds = (time) ->
  if time.indexOf(':') >= 0
    parseInt(time.split(':')[0], 10)*60 + parseInt(time.split(':')[1], 10)
  else
    parseInt(time)


setInterval(() ->
  return if $('#timer').length == 0
  return if $('#timer').data('pause') == 'true'

  seconds = getSeconds($('#timer').text())

  $('#timer').text(formatTime(seconds-1)) if seconds > 0

  fillwidth = 100*(seconds-1)/$('#timer').data('maxtime')
  $('#timeviz-fill').width(fillwidth + "%")
  $('#timeviz-fill').css('background', '#fcc') if fillwidth < 10

  if seconds <= 1 and not $('#beep').hasClass('beeped')
    $('#beep').get(0).play()
    $('#beep').addClass('beeped')

, 1000)


plotLogs = () ->

  points = []
  points.push($('#log-chart').data('pts'))
  console.log(points)

  $.plot($('#log-chart'), points, {
             lines : { show: true, fill: 0 },
             xaxis : { tickColor : "#ffffff"},
             yaxis : { tickColor : "#ffffff"},
             grid  : { borderWidth: 0, hoverable: true }})
#
plotLogs()

