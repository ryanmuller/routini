
$(document).ready(function() {
  plotDaily();
});

plotDaily = function() {

  if ($('#daily-chart').length > 0) {
    var points = eval('('+$('#daily-chart').data('pts')+')');

    $.plot($('#daily-chart'), points,
           { 
             lines : { show: true, fill: 1 },
             legend : { position: "nw" },
             xaxis : { tickColor : "#ffffff"},
             grid  : { borderWidth: 0, hoverable: true }});
  }
}


