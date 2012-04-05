window.ShuffCharts =
  renderLogs: (el) ->
    data = $(el).data('pts')
    elid = $(el).attr('id')

    chart = new Highcharts.Chart({
      chart: {
        renderTo: elid,
      },
      title: {
        text: null,
      },
      xAxis: {
        type: 'datetime',
        labels: {
          enabled: false
        }
      },
      yAxis: {
        title: {
          text: "Completed"
        }
      }
      legend: {
        enabled: false
      },
      plotOptions: {
        column: {
          borderWidth: 0
        }
      },
      series: [{
        type: 'column',
        #pointStart: Date(Date.now() - 14*24*3600*1000),
        #pointInterval: 24*3600*1000,
        data: data
      }]
    })

  renderValues: (el) ->
    data = $(el).data('pts')
    elid = $(el).attr('id')

    chart = new Highcharts.Chart({
      chart: {
        renderTo: elid,
      },
      title: {
        text: null,
      },
      xAxis: {
        type: 'datetime'
        labels: {
          enabled: false
        }
      },
      yAxis: {
        title: {
          text: null
        }
      }
      legend: {
        enabled: false
      },
      series: [{
        data: data
      }]
    })


