emailer.controller("metricsCtrl", [ "$scope", "$http", "$routeParams", 
           function metricsCtrl ($scope, $http, $routeParams) {
  $scope.opened   = _.select($scope.recipients, function (r) { return r.tracking_pixel.date_first_viewed != undefined })
  $scope.unopened = _.select($scope.recipients, function (r) { return r.tracking_pixel.sent == true && r.tracking_pixel.date_first_viewed == undefined })
  $scope.unsent   = _.select($scope.recipients, function (r) { return r.tracking_pixel.sent == undefined })
}])

