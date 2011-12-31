

$(document).ready(function() {
  plotPoints();

  $('#chart_days').change(plotPoints);

  $('#shuffler a').hover(function() {
    var context = $(this).text();

    if (context == 'all') {
      $('#task-list li').show();
    } else {
      $('#task-list li').hide();
      $('#task-list li .context:contains('+context+')').parent().show();
    }
  });
});

plotPoints = function() {
  var days = parseInt($('#chart_days').val());

  if ($('#point-chart').length > 0) {
    var points = eval('('+$('#point-chart').data('pts')+')').slice(-1*days);

    for (var i=0; i<points.length; i++) {
      points[i].label = points[i].label.slice(-1*days);
      points[i].data = points[i].data.slice(-1*days);
    }

    $.plot($('#point-chart'), points,
           { 
             lines : { show: true, fill: 1 },
             legend : { position: "nw" },
             xaxis : { tickColor : "#ffffff"},
             grid  : { borderWidth: 0, hoverable: true }});
  }
}

