emailer.controller("CampaignCtrl", ["$scope", "Campaign", function CampaignCtrl ($scope, Campaign) {
  $scope.campaigns = Campaign.query();
}])
