emailer.controller("CampaignEmailCtrl", ["$scope", "$routeParams", "User", "CampaignUser", function CampaignEmailCtrl ($scope, $routeParams, User, CampaignUser) {
  var campaignId = $routeParams.campaignId
  $scope.campaignUsers = CampaignUser.query({campaignId: campaignId})
  $scope.selected = undefined;

  users = User.query(function (users) {
    $scope.emails = _.map(users, function(user) { return user.email })
  });


  $scope.addToCampaign = function (email) {
    if (_.isEmpty(email)) { return }
    // Find the user from the list of people already on the campaign
    // Do nothing if the user is already on the campaign
    var found = _.find($scope.campaignUsers, function (user) { return user.email === email })

    if (!found) {
      var ce = new CampaignUser({campaignId: campaignId, email: email})
      ce.$save(function (data) {
        $scope.campaignUsers.push(data)
      });
    }
    $scope.selected = undefined
  }

  $scope.removeUser = function (userId) {
    var cu = new CampaignUser({campaignId: campaignId, id: userId})
    cu.$remove({campaignId: campaignId}, function (data) {
      $scope.campaignUsers = _.filter($scope.campaignUsers, function (user) { return user.id !== userId} );
    });
  }

}])
