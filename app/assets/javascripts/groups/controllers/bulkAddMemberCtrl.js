groups.controller("bulkAddMemberCtrl", ["$scope", "$http", function bulkAddMemberCtrl($scope, $http) {

  $scope.addContacts = function() {
    $http.post("/api/v1/groups/" + $scope.group.id + "/members/bulk", {emails: $scope.bulkEmailAddresses}, function (response) {
      $scope.bulkEmailAddresses = undefined;
    })
  }

}])

