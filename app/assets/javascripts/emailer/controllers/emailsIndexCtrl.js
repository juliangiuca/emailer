emailer.controller("EmailsIndexCtrl", ["$scope", "$http",
          function EmailsIndexCtrl ($scope, $http) {

  var fetchEmails = function() {
    $http.get("/api/v1/emails")
      .then(function(emails) {
        $scope.sent   = _.select(emails.data, function (e) { return e.sent_on })
        $scope.unsent = _.select(emails.data, function (e) { return !e.sent_on })
    })
  }

  $scope.removeEmail = function(email) {
    $http.delete("/api/v1/emails/" + email.id)
      .then(function() {
        fetchEmails();
      });
  }

  fetchEmails();

}])
