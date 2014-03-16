emailer.controller("ShowEmailsCtrl", ["$scope", "$routeParams", "$modal", "Email", "Recipient", function ShowEmailsCtrl ($scope, $routeParams, $modal, Email, Recipient) {
  Email.get(
    {
      emailId: $routeParams.emailId
    },
    function(resp) {
      $scope.recipients = Recipient.query({"emailId": resp.id});
      $scope.email = resp;
    });

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

  $scope.showConfirmationPopup = function () {
    var modalInstance = $modal.open({
      templateUrl: 'confirmationDialog',
      controller: "EmailConfirmationCtrl",
      resolve: {
        email: function() {
          return $scope.email;
        },
      } //resolve
    }); //$modal.open

    modalInstance.result.then(function () {
      //They pressed OK
      $scope.email.$send()

    }, function () {
      //They pressed cancel
    });
  }

}])

