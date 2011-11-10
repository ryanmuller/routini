# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

setInterval(() ->
  time = parseInt($('#timer').text())

  console.log(time)
  $('#timer').text(time-1) if time > 0

  snd = new Audio('/timer.wav')
  snd.play() if time == 1
, 1000)
    

