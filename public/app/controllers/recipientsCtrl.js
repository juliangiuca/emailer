emailer.controller("RecipientsCtrl", ["$scope", "$http", "Contact", "Recipient", function RecipientsCtrl ($scope, $http, Contact, Recipient) {
  //$scope.recipients = Recipient.query({"emailId": $scope.email.id});
  $scope.contacts = Contact.query()
  $scope.selected = undefined;

  $scope.addRecipientOrContact = function() {
    debugger
    i=0
    i+=1
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

