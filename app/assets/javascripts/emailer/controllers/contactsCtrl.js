emailer.controller("ContactsCtrl", ["$scope", "$routeParams", "Contact", "Recipient", function ContactsCtrl ($scope, $routeParams, Contact, Recipient) {
  $scope.contacts = Contact.query();

  $scope.addContact = function () {
    var newContact = $scope.newContact
    var contact = new Contact(newContact)
    contact.$save(function (data) {
      $scope.contacts.push(data)
      $scope.newContact = null
    });
  }
}])

