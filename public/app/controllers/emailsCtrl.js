emailer.controller("EmailsCtrl", ["$scope", "Email", function EmailsCtrl ($scope, Email) {
  var email = $scope.email = Email.save();

  $scope.$watch("email.body", function(a,b) {
    $scope.email.$update({"changed": "body"})

  }, true);

}])

