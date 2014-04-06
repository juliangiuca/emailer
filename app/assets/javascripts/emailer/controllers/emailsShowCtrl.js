emailer.controller("EmailsShowCtrl",
                    [
                      "$scope",
                      "$http",
                      "$routeParams",
                      "$modal",
                      "$cookieStore",
                      "$location",
                      "Email",
                      "Recipient",
                      function ShowEmailsCtrl ($scope, $http, $routeParams, $modal, $cookieStore, $location, Email, Recipient) {

  Email.get(
    {
      emailId: $routeParams.emailId
    },
    function(resp) {
      $scope.recipients = Recipient.query({"emailId": resp.id});
      $scope.email   = resp;
      $scope.body    = _.clone(resp.body);
      $scope.subject = _.clone(resp.subject);
      console.log("ding")
    }, function(err) {
      $cookieStore.remove('unsentEmailId');
      $location.path("/emails/new")
    });

  // Debounce to prevent a bunch of save calls from being triggered
  // We don't really care about the response - we want to just send updates down the wire
  // which is why we have walked away from the two way binding of email.body
  $scope.saveBody = _.debounce(function() {
    $http.put('/emails/' + $scope.email.id, {changed: "body", body: $scope.body})
  }, 1000)

  $scope.$watch("body", function(newBody, oldBody) {
    if (oldBody !== newBody && newBody !== $scope.email.body) {
      $scope.saveBody()
    }
  });


  $scope.saveSubject = _.debounce(function() {
    $http.put('/emails/' + $scope.email.id, {changed: "subject", subject: $scope.subject})
  }, 1000)

  $scope.$watch("subject", function(newSubject, oldSubject) {
    if (newSubject !== oldSubject && newSubject !== $scope.email.subject) {
      $scope.saveSubject();
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
      $scope.email.$deliver()

    }, function () {
      //They pressed cancel
    });
  }

}])
