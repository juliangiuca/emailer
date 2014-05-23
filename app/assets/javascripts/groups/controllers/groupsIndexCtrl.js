groups.controller("GroupsIndexCtrl", ["$scope", "$http", "Group",
function GroupsIndexCtrl ($scope, $http, Group) {
  $scope.groups = Group.query();

  $scope.addGroup = function() {
    var g = new Group($scope.newGroup)
    g.$save(function (data) {
      $scope.groups.push(data)
      $scope.newGroup = undefined;
    })
  }

  $scope.removeGroup = function(group) {
    $http.delete("/api/v1/groups/" + group.id)
      .then(function(data) {
        $scope.groups = _.reject($scope.groups, function(g) { return g.id == group.id; })
      }, function(err) {
        //Could not delete group
        $scope.error = "Could not delete group " + group.name + "."
      })
  }

  $scope.closeAlert = function() {
    $scope.error = undefined;
  }
}])
