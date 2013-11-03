emailer.controller("CampaignCtrl", ["$scope", "$routeParams", "Campaign", function CampaignCtrl ($scope, $routeParams, Campaign) {
  $scope.campaigns = Campaign.query();

  $scope.addCampaign = function(thingie) {
    var newCampaign = $scope.newCampaign
    var c = new Campaign(newCampaign)
    c.$save(function (data) {
      $scope.campaigns.push(data)
    });
  }
}])

emailer.controller("CampaignShowCtrl", ["$scope", "$routeParams", "Campaign", function CampaignShowCtrl ($scope, $routeParams, Campaign) {
  $scope.campaign = Campaign.get({campaignId: $routeParams.campaignId});

  $scope.editName = function () {
    $scope.editing = true
    $scope.editingName = true
  }

  $scope.editBody = function () {
    $scope.editing = true
    $scope.editingBody = true
  }

  $scope.doneEditingName = function () {
    $scope.editing = null
    $scope.editingName = null;
    $scope.campaign.$update({changed: "name"})
  };

  $scope.doneEditingBody = function () {
    $scope.editingBody = null;
    $scope.saveBody()
  }

  $scope.saveBody = function () {
    $scope.editing = null
    $scope.campaign.$update({changed: "body"})
  };
}]);
