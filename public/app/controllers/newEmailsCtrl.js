emailer.controller("NewEmailsCtrl", ["$scope", "$cookieStore", "$location", "$q", "Email", "Recipient", function NewEmailsCtrl ($scope, $cookieStore, $location, $q, Email, Recipient) {

  goToEmail = function() {
    $location.path("/emails/" + getNewEmailCookie())
  }

  setNewEmailCookie = function(emailId) {
    $cookieStore.put('unsentEmailId', emailId);
  }

  getNewEmailCookie = function() {
    return $cookieStore.get('unsentEmailId')
  }

  fetchRecipients = function(emailId) {
    $scope.recipients = Recipient.query({"emailId": emailId});
  }

  createEmail = function() {
    var deferred = $q.defer();

    Email.save(function(resp) {
      $scope.email = resp;
      deferred.resolve(resp.id)
    });

    return deferred.promise;
  }

  if (getNewEmailCookie()) {
    goToEmail();
  } else {
    createEmail().then(function(emailId) {
      fetchRecipients(emailId)
      return emailId
    }).then(function(emailId) {
      setNewEmailCookie(emailId);
    }).then(function() {
      goToEmail();
    });
  }


}])

