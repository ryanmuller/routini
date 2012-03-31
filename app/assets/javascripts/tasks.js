var formatTime, getSeconds, plotLogs;

plotLogs = function() {
  var points;
  if ($('#log-chart').length != 0) {
    points = [];
    points.push($('#log-chart').data('pts'));
    $.plot($('#log-chart'), points, {
      bars: { show: true, fill: 1 },
      xaxis: { tickColor: "#ffffff" },
      yaxis: { tickColor: "#ffffff" },
      grid: { borderWidth: 0, hoverable: true }
    });
  }

  $('.mini-chart').each(function() {
    points = [];
    points.push($(this).data('pts'));

    chart = new Highcharts.Chart({
      chart: {
        renderTo: $(this).attr('id'),
        type: 'spline'
      },
      title: {
        text: null
      },
      legend: {
        enabled: false
      },
      series: [{
        name: 'Points',
        data: $(this).data('pts')
      }]
    });
    //$.plot($(this), points, {
    //  bars: { show: true, fill: 1 },
    //  xaxis: { ticks: 0, tickColor: "#ffffff" },
    //  yaxis: { ticks: 0, tickColor: "#ffffff" },
    //  grid: { borderWidth: 0, hoverable: true }
    //});
  });
};

$(function() {
  plotLogs();
  $('.action-cb').change(function() {
    if ($(this).is(':checked')) {
      $(this).next().css('text-decoration', 'line-through');
      $(this).next().next().attr('value', 'complete');
    } else {
      $(this).next().css('text-decoration', 'none');
      $(this).next().next().attr('value', 'incomplete');
    }
    return $(this).parent().submit();
  });
  $('#pause').click(function() {
    if ($('#timer').data('pause') === 'true') {
      $('#timer').data('pause', 'false');
      return $('#pause > img').attr('src', '/assets/pause.png');
    } else {
      $('#timer').data('pause', 'true');
      return $('#pause > img').attr('src', '/assets/play.png');
    }
  });
  $('#reset').click(function() {
    $('#beep').removeClass('beeped');
    return $('#timer').data('over', 'false').removeClass('over').text(formatTime($('#timer').data('maxtime')));
  });
});

formatTime = function(time) {
  var out;
  out = "";
  out += Math.floor(time / 60);
  out += ":";
  if (time % 60 < 10) {
    out += "0";
  }
  out += time % 60;
  return out;
};

getSeconds = function(time) {
  if (time.indexOf(':') >= 0) {
    return parseInt(time.split(':')[0], 10) * 60 + parseInt(time.split(':')[1], 10);
  } else {
    return parseInt(time);
  }
};


setInterval(function() {
  var fillwidth, seconds, timer;
  timer = $('#timer');
  if (timer.length === 0) {
    return;
  }
  if (timer.data('pause') === 'true') {
    return;
  }
  seconds = getSeconds($('#timer').text());
  if (timer.data('over') === 'true') {
    timer.text(formatTime(seconds + 1));
  } else {
    if (seconds > 0) {
      timer.text(formatTime(seconds - 1));
    }
    fillwidth = 100 * (seconds - 1) / timer.data('maxtime');
    $('#timeviz-fill').width(fillwidth + "%");
    if (fillwidth < 10) {
      $('#timeviz-fill').css('background', '#fcc');
    }
  }
  if (seconds <= 1 && !$('#beep').hasClass('beeped')) {
    $('#beep').get(0).play();
    $('#beep').addClass('beeped');
    timer.addClass('over');
    return timer.data('over', 'true');
  }
}, 1000);


