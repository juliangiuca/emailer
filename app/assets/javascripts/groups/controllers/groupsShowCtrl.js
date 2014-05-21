groups.controller("GroupsShowCtrl", ["$scope", "$rootScope", "$state", "Group", "GroupMember", "Contact", "preFetched", 
    function GroupsShowCtrl ($scope, $rootScope, $state, Group, GroupMember, Contact, preFetched) {

  $rootScope.$state = $state;

  $scope.group   = preFetched.group
  $scope.members = GroupMember.query({groupId: $scope.group.id});

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
