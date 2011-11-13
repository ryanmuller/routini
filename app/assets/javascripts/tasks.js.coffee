# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


setTimeout(() ->
  $('.action-cb').change(() ->

    if $(this).is(':checked') 
      $(this).next().css('text-decoration', 'line-through')
      $(this).next().next().attr('value', 'complete')
    else
      $(this).next().css('text-decoration', 'none')
      $(this).next().next().attr('value', 'incomplete')

    $(this).parent().submit()
  )
, 1000)



setInterval(() ->
  time = parseInt($('#timer').text())

  $('#timer').text(time-1) if time > 0

  snd = new Audio('/timer.wav')
  snd.play() if time == 1
, 1000)
   


