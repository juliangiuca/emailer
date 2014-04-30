emailer.controller("GroupsIndexCtrl", ["$scope", "Group", function GroupsIndexCtrl ($scope, Group) {
  $scope.groups = Group.query();

  $scope.addGroup = function() {
    var g = new Group($scope.newGroup)
    g.$save(function (data) {
      $scope.groups.push(data)
      $scope.newGroup = undefined;
    })
  }
}])
