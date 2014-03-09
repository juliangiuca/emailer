emailer.controller("EmailsCtrl", ["$scope", "Email", function EmailsCtrl ($scope, Email) {
  $scope.email = Email.save();

}])

