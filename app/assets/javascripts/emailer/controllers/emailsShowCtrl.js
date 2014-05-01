emailer.controller("EmailsShowCtrl",
                    [
                      "$scope", "$http", "$routeParams", "$modal", "$cookieStore", "$location",
                      "preFetched", "Recipient",
                      function ShowEmailsCtrl ($scope, $http, $routeParams, $modal, $cookieStore, $location, preFetched, Recipient) {

  $scope.interactWith  = "compose";
  $scope.addRecipients = false
  var recipients       = $scope.recipients = preFetched.recipients
  var email            = $scope.email      = preFetched.email
  $scope.body          = _.clone(email.body);
  $scope.subject       = _.clone(email.subject);
  $cookieStore.put('unsentEmailId', email.id);
  $scope.enableMetrics = _.find(recipients, function (r) { return r.tracking_pixel.sent === true })


  // Debounce to prevent a bunch of save calls from being triggered
  // We don't really care about the response - we want to just send updates down the wire
  // which is why we have walked away from the two way binding of email.body
  $scope.saveEmail = _.debounce(function() {
    $http.put('/api/v1/emails/' + $scope.email.id, {body: $scope.body, subject: $scope.subject})
  }, 1000)

  $scope.$watch("body", function(newBody, oldBody) {
    if (oldBody !== newBody && newBody !== $scope.email.body) {
      $scope.saveEmail()
    }
  });

  $scope.$watch("subject", function(newSubject, oldSubject) {
    if (newSubject !== oldSubject && newSubject !== $scope.email.subject) {
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
