emailer.controller("NewEmailsCtrl", ["$scope", "Email", "Recipient", function NewEmailsCtrl ($scope, Email, Recipient) {
  Email.save(function(resp) {
    $scope.recipients = Recipient.query({"emailId": resp.id});
    $scope.email = resp;
  });

}])

