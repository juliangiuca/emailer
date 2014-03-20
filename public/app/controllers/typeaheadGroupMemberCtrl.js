emailer.controller("typeaheadGroupMemberCtrl", ["$scope", "$http", "Contact", "GroupMember", function typeaheadGroupMemberCtrl ($scope, $http, Contact, GroupMember) {
  $scope.contacts = Contact.query()
  $scope.selected = undefined;

  $scope.addContact = function() {
    var emailAddress;
    var isAnObj = angular.isObject($scope.selected);

    if (isAnObj)      emailAddress = $scope.selected.email_address
    else              emailAddress = $scope.selected

    groupMember = new GroupMember();
    groupMember.$save({
      groupId: $scope.group.id,
      contactEmail: emailAddress
    },
      function (res) {
        $scope.members.push(res);
        $scope.selected = undefined;
      })
  };

}])
