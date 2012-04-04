window.ShuffCharts =
  renderChart: (el) ->
    data = $(el).data('pts')
    elid = $(el).attr('id')

    chart = new Highcharts.Chart({
      chart: {
        renderTo: elid,
        type: 'spline'
      },
      title: {
        text: null,
      },
      legend: {
        enabled: false
      },
      series: [{
        name: 'Points',
        data: data
      }]
    })


