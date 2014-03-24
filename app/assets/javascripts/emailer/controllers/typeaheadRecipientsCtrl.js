emailer.controller("typeaheadRecipientsCtrl", ["$scope", "$http", "$q", "Contact", "Recipient", "Group", "GroupMember", function typeaheadRecipientsCtrl ($scope, $http, $q, Contact, Recipient, Group, GroupMember) {
  $scope.contacts = $scope.groups = $scope.selected = undefined

  var getRecipients = function() {
    Recipient.query({emailId: $scope.email.id},
      function (recipients) {
        if ($scope.recipients != recipients)
          $scope.recipients = recipients
      });
  }

  $q.all([
    Contact.query().$promise,
    Group.query().$promise
  ]).then(function (results) {
    $scope.contactsOrGroups = _.union(results[0], results[1])
  })

  $scope.addRecipientOrContact = function() {
    var userPicked = _.clone($scope.selected);
    var isAnObj = angular.isObject(userPicked);

    if (!isAnObj)
      userPicked = new Recipient({emailAddress: userPicked})

    var picked = userPicked.$addToEmail(
      {
        emailId: $scope.email.id,
      });

    picked.then(function(data) {
      console.log($scope.contactsOrGroups)
      $scope.selected = undefined;
      getRecipients();
    }, function(err) {
      $scope.selected = undefined;
    })

    return {hi: "lo"};
  };

  $scope.removeRecipient = function(recipient) {
    recipient.$delete(
      {
        emailId: $scope.email.id,
        recipientId: recipient.id
      },
      function (res) {
        getRecipients();
    });
  }

}])
