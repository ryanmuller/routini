
$(document).ready(function() {

  console.log($('#point-chart').data('pts'));
  $.plot($('#point-chart'), eval('('+$('#point-chart').data('pts')+')'),
         { 
           xaxis : { tickColor : "#ffffff"},
           grid  : { borderWidth: 0, hoverable: true }});
});

