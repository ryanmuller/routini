# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
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
      $('#pause').text('pause')
    else
      $('#timer').data('pause','true')
      $('#pause').text('resume')
  )

  $('#reset').click(() ->
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

snd = new Audio('/timer.wav')

setInterval(() ->
  return if $('#timer').data('pause') == 'true'

  seconds = getSeconds($('#timer').text())
  console.log(seconds)

  $('#timer').text(formatTime(seconds-1)) if seconds > 0

  fillwidth = 100*(seconds-1)/$('#timer').data('maxtime')
  $('#timeviz-fill').width(fillwidth + "%")
  $('#timeviz-fill').css('background', '#fcc') if fillwidth < 10

  snd.play() if seconds == 1
, 1000)


   


