emailer.directive('pie', function () {
  return {
    restrict: 'E',
    replace: true,
    template: '<div><i class="fa fa-cog fa-spin"></i></div>',
    link: function (scope, element, attrs) {

      var drawChart = function(data) {

        var chart = new Highcharts.Chart({
          chart: {
            renderTo: element[0],
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
          },
          title: {
            text: attrs.chartTitle
          },
          tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
          },
          plotOptions: {
            pie: {
              size: 200,
              animation:true,
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                style: {
                  color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                }
              }
            },
          },
          series: [{
            type: 'pie',
            name: 'Browser share',
            data: data
          }]
        });
      }

      scope.$watch(attrs.chartData, function (data) {
        if (_.isUndefined(data)) { return }

        drawChart(data)
      }, true);
    }
  }
});
