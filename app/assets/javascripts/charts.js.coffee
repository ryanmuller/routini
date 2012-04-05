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
          shadow: false,
          borderWidth: 0,
          pointWidth: 2,
          pointPadding: 1,
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
    for item in data
      parts = item[0].split("-")
      item[0] = Date.UTC(parts[0], parts[1], parts[2])
      item[1] = parseInt(item[1])

    data = data.slice(-14)
    
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


