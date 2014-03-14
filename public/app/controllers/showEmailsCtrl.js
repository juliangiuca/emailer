emailer.controller("ShowEmailsCtrl", ["$scope", "$routeParams", "$modal", "Email", "Recipient", function ShowEmailsCtrl ($scope, $routeParams, $modal, Email, Recipient) {
  Email.get(
    {
      emailId: $routeParams.emailId
    },
    function(resp) {
      $scope.recipients = Recipient.query({"emailId": resp.id});
      $scope.email = resp;
    });

  $scope.showConfirmationPopup = function () {
    var modalInstance = $modal.open({
      templateUrl: 'confirmationDialog',
      controller: "EmailConfirmationCtrl",
      resolve: {
        campaign: function() {
          return $scope.campaign;
        },
      } //resolve
    }); //$modal.open

    modalInstance.result.then(function () {
      //They pressed OK
      $scope.campaign.$deliver()

    }, function () {
      //They pressed cancel
    });
  }

}])

