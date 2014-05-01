emailer.controller("EmailsShowCtrl", [ "$scope", "$http", "$routeParams", "$modal", "$cookieStore", "$location", "preFetched", "Recipient",
           function EmailsShowCtrl ($scope, $http, $routeParams, $modal, $cookieStore, $location, preFetched, Recipient) {

  $scope.interactWith  = "compose";
  $scope.addRecipients = false
  var recipients       = $scope.recipients = preFetched.recipients
  var email            = $scope.email      = preFetched.email
  $cookieStore.put('unsentEmailId', email.id);
  $scope.enableMetrics = _.find(recipients, function (r) { return r.tracking_pixel.sent === true })


  // Debounce to prevent a bunch of save calls from being triggered
  // We don't really care about the response - we want to just send updates down the wire
  $scope.saveEmail = _.debounce(function() {
    $http.put('/api/v1/emails/' + $scope.email.id, {body: $scope.email.body, subject: $scope.email.subject})
  }, 1000)

  $scope.$watch("email.body", function(newBody, oldBody) {
    if (oldBody !== newBody) {
      $scope.saveEmail()
    }
  });

  $scope.$watch("email.subject", function(newSubject, oldSubject) {
    if (newSubject !== oldSubject) {
      $scope.saveEmail();
    }
  });

  $scope.getRecipients = function() {
    Recipient.query({emailId: $scope.email.id},
      function (recipients) {
        if ($scope.recipients != recipients) {
          $scope.recipients = recipients
        }
      });
  }

  $scope.showConfirmationPopup = function () {
    debugger
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
      $scope.email.$deliver()

    }, function () {
      //They pressed cancel
    });
  }

}])
