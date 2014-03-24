emailer.controller("EmailConfirmationCtrl", ["$scope", "$modalInstance", "email", function EmailConfirmationCtrl ($scope, $modalInstance, email) {
  $scope.email = email;

  $scope.ok = function () {
    $modalInstance.close();
  };

  $scope.cancel = function () {
    $modalInstance.dismiss('cancel');
  };
}]);

