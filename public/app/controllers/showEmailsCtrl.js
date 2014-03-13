emailer.controller("ShowEmailsCtrl", ["$scope", "$routeParams", "Email", "Recipient", function ShowEmailsCtrl ($scope, $routeParams, Email, Recipient) {
  Email.get(
    {
      emailId: $routeParams.emailId
    },
    function(resp) {
      $scope.recipients = Recipient.query({"emailId": resp.id});
      $scope.email = resp;
    });

}])

