//Different fail types
//opens
//hard bounce
//soft bounce - inbox is full
//reports as spam

emailer.controller("metricsCtrl", [ "$scope", "$http", "$q",
           function metricsCtrl ($scope, $http, $q) {

  $scope.openedChart = undefined;
  $scope.deliveryChart = undefined;

  var filterRecipients = function() {

    $scope.opened   = _.select($scope.recipients,
      function (r) { return r.tracking_pixel.date_first_viewed != undefined });

    $scope.unopened = _.select($scope.recipients,
      function (r) { return r.tracking_pixel.sent && r.tracking_pixel.date_first_viewed == undefined })

    $scope.unsent   = _.select($scope.recipients,
      function (r) { return r.tracking_pixel.sent == undefined })

    $scope.sent     = _.select($scope.recipients,
      function (r) { return r.tracking_pixel.sent })

  }

  var drawChart = function() {
    $scope.openedChart = [
      {name: "Opened", y: $scope.opened.length, selected: true, sliced: true},
      ["Unopened", $scope.unopened.length]
    ]

    $scope.deliveryChart = [
      {name: "Sent", y: $scope.sent.length},
      ["Unsent", $scope.unsent.length],
    ]
  }

  if (_.isUndefined($scope.recipients)) {
    $scope.getRecipients()
    .then(function () {
      filterRecipients();
      drawChart();
    })
  } else {
    filterRecipients();
    drawChart();
  }

}])
