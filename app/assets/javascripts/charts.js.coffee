window.ShuffCharts =
  renderDaily: (el, data) ->

    elid = $(el).attr('id')

    total_pts =  0
    for datum in data
      total_pts += datum.data[6]

    chart = new Highcharts.Chart({
      chart: {
        renderTo: elid,
        type: 'column'
      },
      title: {
        text: "Tasks completed today: " + total_pts,
      },
      legend: {
        layout: 'horizontal',
        align: 'left',
        verticalAlign: 'top',
        x: 20,
        y: 20,
        floating: true,
        borderWidth: 1,
      },
      yAxis: {
        title: {
          text: null
        }
      },
      plotOptions: {
        column: {
          fillOpacity: 1,
          stacking: 'normal',
          lineWidth: 0,
          groupPadding: 0,
          pointPadding: 0.05,
          shadow: false
        }
      },
      series: data
    })
    #chart = new Highcharts.Chart({
    #  chart: {
    #    renderTo: elid,
    #    type: 'pie',
    #  },
    #  title: {
    #    text: "Tasks completed today: " + total_pts,
    #  }
    #  series: [{
    #    type: 'pie',
    #    name: 'Points',
    #    size: '40%',
    #    innerSize: '20%',
    #    data: data
    #  }]
    #})


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
          groupPadding: 0,
          pointPadding: 0.1,
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
      # deal with getting time as int
      # TODO no idea why this is happening...
      if typeof(item[0]) == 'string'
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


