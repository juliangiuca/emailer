emailer.controller("metricsCtrl", [ "$scope", "$http",
           function metricsCtrl ($scope, $http) {
  $scope.opened   = _.select($scope.recipients, function (r) { return r.tracking_pixel.date_first_viewed != undefined })
  $scope.unopened = _.select($scope.recipients, function (r) { return r.tracking_pixel.sent == true && r.tracking_pixel.date_first_viewed == undefined })
  $scope.unsent   = _.select($scope.recipients, function (r) { return r.tracking_pixel.sent == undefined })

  //opens
  //hard bounce
  //soft bounce - inbox is full
  //reports as spam

  $scope.chartConfig = {
    options: {
      chart: {
        type: 'pie',
        zoomType: 'x'
      },
      tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
      },
      plotOptions: {
        pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
            enabled: true,
            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
            style: {
              color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
            }
          }
        }
      }
    },
    series: [{
      type: 'pie',
      name: 'Browser share',
      data: [
      ['Opened',   $scope.opened.length],
      ['Unopened', $scope.unopened.length],
      // {
      //   name: 'Opens',
      //   y: 12.8,
      //   sliced: true,
      //   selected: true
      // },
      ]
    }],
    title: {
      text: 'Open rate'
    },
    xAxis: {currentMin: 0, currentMax: 10, minRange: 1},
    loading: false
  }
}])
