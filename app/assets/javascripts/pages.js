
$(document).ready(function() {

  if ($('#point-chart').length > 0) {
    $.plot($('#point-chart'), eval('('+$('#point-chart').data('pts')+')'),
           { 
             lines : { show: true, fill: 1 },
             legend : { position: "nw" },
             xaxis : { tickColor : "#ffffff"},
             grid  : { borderWidth: 0, hoverable: true }});
  }

});

