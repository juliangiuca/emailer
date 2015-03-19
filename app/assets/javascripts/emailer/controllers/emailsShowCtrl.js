emailer.controller("EmailsShowCtrl", [ "$scope", "$rootScope", "$http", "$state", "$modal", "$cookieStore", "$location", "$q", "preFetched", "Recipient",
           function EmailsShowCtrl ($scope, $rootScope, $http, $state, $modal, $cookieStore, $location, $q, preFetched, Recipient) {

  $rootScope.$state = $state;

  $scope.addRecipients = false;
  var recipients       = $scope.recipients = preFetched.recipients;
  var email            = $scope.email      = preFetched.email;

  $http.get("/api/v1/emails/" + $scope.email.id + "/recipients")
    .then(function (response) {
      $scope.recipients = response.data;
      $scope.enableMetrics = true;
    })

  $cookieStore.put('unsentEmailId', email.id);

  // Debounce to prevent a bunch of save calls from being triggered
  // We don't really care about the response - we want to just send updates down the wire
  $scope.saveEmail = _.debounce(function() {
    $http.put('/api/v1/emails/' + $scope.email.id, {body: $scope.email.body, subject: $scope.email.subject})
  }, 1000)

  $scope.$watch("email.body", function(newBody, oldBody) {
    if (oldBody !== newBody) {
      mixpanel.track('Editing body');
      $scope.saveEmail()
    }
  });

  $scope.$watch("email.subject", function(newSubject, oldSubject) {
    if (newSubject !== oldSubject) {
      mixpanel.track('Editing subject');
      $scope.saveEmail();
    }
  });

  $scope.getRecipients = function() {
    var deferred = $q.defer();

    Recipient.query({emailId: $scope.email.id},
      function (recipients) {
        $scope.recipients = recipients
        deferred.resolve();
      });

    return deferred.promise;
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
      //$scope.email.$deliver()
      mixpanel.track('Sending email');
      $http.post("/api/v1/emails/" + $scope.email.id + "/deliver")

    }, function () {
      //They pressed cancel
    });
  }

}])
