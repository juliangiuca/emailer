emailer.controller("RecipientsCtrl", ["$scope", "Contact", "Recipient", function RecipientsCtrl ($scope, Contact, Recipient) {
  debugger
  $scope.recipients = Recipient.query({"emailId": $scope.email.id});

  //$scope.addContact = function () {
    //var newContact = $scope.newContact
    //var contact = new Contact(newContact)
    //contact.$save(function (data) {
      //$scope.contacts.push(data)
      //$scope.newContact = null
    //});
  //}
}])

