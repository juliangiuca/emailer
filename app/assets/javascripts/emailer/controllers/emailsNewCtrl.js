emailer.controller("EmailsNewCtrl", ["$scope", "$cookieStore", "$location", "$q", "Email", "Recipient", function NewEmailsCtrl ($scope, $cookieStore, $location, $q, Email, Recipient) {

  goToEmail = function() {
    $location.path("/emails/" + getNewEmailCookie())
  }

  setNewEmailCookie = function(emailId) {
    $cookieStore.put('unsentEmailId', emailId);
    return emailId;
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
    }, function(err) {
      console.log("Save failed. " + err);
      deferred.reject(err);
    });

    return deferred.promise;
  }

  if (getNewEmailCookie()) {
    goToEmail();
  } else {
    createEmail().then(function(emailId) {
      console.log("email ID is: " + emailId);
      return setNewEmailCookie(emailId);
    }, function(err) {
      console.log("couldn't create email");
      debugger
      var i=0
    }).then(function(emailId) {
      return fetchRecipients(emailId)
    }, function (err) {
      console.log("what.")
      debugger
      var i=0
    }).then(function() {
      return goToEmail();
    });
  }


}])
