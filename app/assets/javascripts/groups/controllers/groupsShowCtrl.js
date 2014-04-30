groups.controller("GroupsShowCtrl", ["$scope", "$routeParams", "Group", "GroupMember", "Contact", function GroupsShowCtrl ($scope, $routeParams, Group, GroupMember, Contact) {
  $scope.group = Group.get({groupId: $routeParams.groupId})
  $scope.members = GroupMember.query({groupId: $routeParams.groupId});

  $scope.removeMember = function(member) {
    member.$delete(
      {
        groupId: $scope.group.id,
        memberId: member.id
      },
      function (res) {
      $scope.members = _.filter($scope.members, function (r) { return r != res })
    });
  };

  $scope.updateMember = function(data) {
    var contact = new Contact(data);
    return contact.$update()
  };

  $scope.updateGroupName = function(data) {
    var group = $scope.group;
    group.name = data;
    return group.$update()
  }
}])
