contacts.controller("indexCtrl", [ "$scope", "$http", "Contact",
function indexCtrl($scope, $http, Contact) {

  $scope.contacts = Contact.query();

  $scope.removeContact = function(contact) {
    $http.delete("/api/v1/contacts/" + contact.id)
      .then(function() {
        $scope.contacts = _.reject($scope.contacts, function(c) { return c.id == contact.id; })
      }, function(err) {
        //do nothing

      })
  }

  $scope.addContact = function() {
    $scope.error = undefined;

    $http.post("/api/v1/contacts", {email_address: $scope.email})
      .then(function(resp) {
        $scope.contacts.push(resp.data);
        $scope.email = undefined;
      }, function(err) {
        //couldn't add to the database
        $scope.error = err.data.error
      }
    )
  }

  $scope.updateContact = function(data) {
    var contact = new Contact(data)
    contact.$update()
  }

  $scope.closeAlert = function() {
    $scope.error = undefined;
  }

}])
