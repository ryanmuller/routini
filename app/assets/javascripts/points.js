
$(document).ready(function() {
  plotDaily();
});

plotDaily = function() {

  if ($('#daily-chart').length > 0) {

    var chart = new Highcharts.Chart({
      chart: {
        renderTo: 'daily-chart',
        type: 'pie'
      },
      title: {
        text: "Today's points"
      },
      series: [{
        type: 'pie',
        name: 'Role points',
        size: "40%",
        innerSize: '20%',
        data: $('#daily-chart').data('pts')
      }]
    });
  }
}


