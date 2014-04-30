emailer.controller("GroupsShowCtrl", ["$scope", "$routeParams", "Group", "GroupMember", function GroupsShowCtrl ($scope, $routeParams, Group, GroupMember) {
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
  }
}])
