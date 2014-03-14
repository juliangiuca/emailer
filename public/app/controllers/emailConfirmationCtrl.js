emailer.controller("EmailConfirmationCtrl", ["$scope", "$modalInstance", "campaign", function EmailConfirmationCtrl ($scope, $modalInstance, campaign) {
  $scope.campaign = campaign;

  $scope.ok = function () {
    $modalInstance.close();
  };

  $scope.cancel = function () {
    $modalInstance.dismiss('cancel');
  };
}]);

