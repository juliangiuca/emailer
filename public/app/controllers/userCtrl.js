emailer.controller("UserCtrl", ["$scope", "$routeParams", "User", function UserCtrl ($scope, $routeParams, User) {

  $scope.users = User.query(function (data) {
    $scope.emails = _.map($scope.users, function(user) { return user.email })
  });
  $scope.selected = undefined;

  $scope.addUser = function () {
    var newUser = $scope.newUser
    var user = new User(newUser)
    user.$save(function (data) {
      $scope.users.push(data)
      $scope.newUser = null
    });
  }
}])

