emailer.controller("RecipientsCtrl", ["$scope", "$http", "Contact", "Recipient", function RecipientsCtrl ($scope, $http, Contact, Recipient) {
  $scope.contacts = Contact.query()
  $scope.selected = undefined;

  $scope.addRecipientOrContact = function() {
    var emailAddress;
    var isAnObj = angular.isObject($scope.selected);

    if (isAnObj)      emailAddress = $scope.selected.email_address
    else              emailAddress = $scope.selected

    var recipient = new Recipient();
    recipient.$save(
      {
        emailId: $scope.email.id,
        contactEmail: emailAddress
      },
      function (res) {
        $scope.recipients.push(res);
        $scope.selected = undefined;
      })
  };

  $scope.removeRecipient = function(recipient) {
    recipient.$delete(
      {
        emailId: $scope.email.id,
        recipientId: recipient.id
      },
      function (res) {
      $scope.recipients = _.filter($scope.recipients, function (r) { return r != res })
    });
  }

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
