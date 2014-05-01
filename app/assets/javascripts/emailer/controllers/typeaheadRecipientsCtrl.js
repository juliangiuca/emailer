emailer.controller("typeaheadRecipientsCtrl", ["$scope", "$http", "$q", "Contact", "Recipient", "Group", "GroupMember",
           function typeaheadRecipientsCtrl ($scope, $http, $q, Contact, Recipient, Group, GroupMember) {

  $scope.contacts = $scope.groups = $scope.selected = undefined

  $q.all([
    Contact.query().$promise,
    Group.query().$promise
  ]).then(function (results) {
    $scope.contactsOrGroups = _.union(results[0], results[1])
  })

  $scope.addRecipientOrContact = function() {
    var userPicked = _.clone($scope.selected);
    var isAnObj = angular.isObject(userPicked);

    //Create the recipient if it's only an email address
    email = (!isAnObj) ? userPicked : false
    email = email || userPicked.email_address

    if (email) {
      $http.post("/api/v1/emails/" + $scope.email.id + "/recipients?emailAddress=" + email)
        .then(function() { return $scope.getRecipients() })
    } else {
      $http.post("/api/v1/emails/" + $scope.email.id + "/recipients?groupId=" + userPicked.id)
        .then(function() { return $scope.getRecipients() })
    }
    $scope.selected = undefined;

  };

  $scope.removeRecipient = function(recipient) {
    $http.delete("/api/v1/emails/" + $scope.email.id + "/recipients/" + recipient.id)
      .then(function() { return $scope.getRecipients() })
  }

  $scope.updateRecipient = function(data) {
    var contact = new Contact(data)
    contact.$update()
  }

}])
