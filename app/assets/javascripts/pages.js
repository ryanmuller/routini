
$(document).ready(function() {

  $.plot($('#point-chart'), [ $('#point-chart').data('pts') ],
         { bars  : { show : true, align : "center" },
           xaxis : { tickColor : "#ffffff", ticks : $('#point-chart').data('ticks') },
           grid  : { borderWidth: 0, hoverable: true }});
});

