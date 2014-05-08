emailer.controller("metricsCtrl", [ "$scope", "$http",
           function metricsCtrl ($scope, $http) {
  $scope.opened   = _.select($scope.recipients, function (r) { return r.tracking_pixel.date_first_viewed != undefined })
  $scope.unopened = _.select($scope.recipients, function (r) { return r.tracking_pixel.sent == true && r.tracking_pixel.date_first_viewed == undefined })
  $scope.unsent   = _.select($scope.recipients, function (r) { return r.tracking_pixel.sent == undefined })

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
              ['Firefox',   45.0],
              ['IE',       26.8],
              {
                  name: 'Chrome',
                  y: 12.8,
                  sliced: true,
                  selected: true
              },
              ['Safari',    8.5],
              ['Opera',     6.2],
              ['Others',   0.7]
          ]
        }],
        title: {
            text: 'Hello'
        },
        xAxis: {currentMin: 0, currentMax: 10, minRange: 1},
        loading: false
    }
}])
