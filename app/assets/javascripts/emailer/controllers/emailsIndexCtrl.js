emailer.controller("EmailsIndexCtrl", ["$scope", "$http",
          function EmailsIndexCtrl ($scope, $http) {

  $http.get("/api/v1/emails")
    .then(function(emails) {

      $scope.sent   = _.select(emails.data, function (e) { return e.sent_on })
      $scope.unsent = _.select(emails.data, function (e) { return !e.sent_on })

    })

}])
