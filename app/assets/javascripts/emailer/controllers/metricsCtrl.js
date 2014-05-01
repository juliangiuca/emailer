emailer.controller("metricsCtrl", [ "$scope", "$http", "$routeParams", 
           function metricsCtrl ($scope, $http, $routeParams) {
  $scope.opened   = _.select($scope.recipients, function (r) { return r.tracking_pixel.sent != undefined })
  $scope.unopened = _.select($scope.recipients, function (r) { return r.tracking_pixel.sent == undefined })
}])

