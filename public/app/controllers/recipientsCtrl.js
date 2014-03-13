emailer.controller("RecipientsCtrl", ["$scope", "$http", "Contact", "Recipient", function RecipientsCtrl ($scope, $http, Contact, Recipient) {
  $scope.contacts = Contact.query()
  $scope.selected = undefined;

  $scope.addRecipientOrContact = function() {
    var recipient = new Recipient();
    recipient.$save(
      {
        emailId: $scope.email.id,
        contactId: $scope.selected.id
      },
      function (res) {
        $scope.recipients.push($scope.selected);
        $scope.selected = undefined;
      })
  };

  //$scope.getLocation = function(val) {
    //return $http.get('/contacts/search/' + val).then(function(res){
      //var addresses = [];
      //angular.forEach(res.data.results, function(item){
        //debugger
        ////addresses.push(item.formatted_address);
        //recipients.push(item)
      //});
      //return addresses;
    //});
  //};

  //$scope.addContact = function () {
    //var newContact = $scope.newContact
    //var contact = new Contact(newContact)
    //contact.$save(function (data) {
      //$scope.contacts.push(data)
      //$scope.newContact = null
    //});
  //}
}])

