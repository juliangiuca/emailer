emailer.controller("EmailsCtrl", ["$scope", "$routeParams", "Email", "Recipient", function EmailsCtrl ($scope, $routeParams, Email, Recipient) {

  $scope.$watch("email.body", function(a,b) {
    if (a != b) {
      $scope.email.$update({"changed": "body"})
    }
  });

  $scope.$watch("email.subject", function(a,b) {
    if (a != b && b != undefined) {
      $scope.email.$update({"changed": "subject"})
    }
  });

}])

