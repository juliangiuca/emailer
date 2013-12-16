emailer.controller("CampaignCtrl", ["$scope", "$routeParams", "Campaign", function CampaignCtrl ($scope, $routeParams, Campaign) {
  $scope.campaigns = Campaign.query();

  $scope.addCampaign = function() {
    var newCampaign = $scope.newCampaign
    var c = new Campaign(newCampaign)
    c.$save(function (data) {
      $scope.campaigns.push(data)
    });
  }
}])

emailer.controller("CampaignShowCtrl", ["$scope", "$routeParams", "$modal", "$log", "Campaign", function CampaignShowCtrl ($scope, $routeParams, $modal, $log, Campaign) {
  $scope.campaign = Campaign.get({campaignId: $routeParams.campaignId});
  $scope.emails = [];


  $scope.saveName = function () {
    $scope.campaign.$update({changed: "name"})
  }

  $scope.saveBody = function () {
    $scope.campaign.$update({changed: "body"})
  };

  $scope.doneEditing = function () {
    $scope.editing = null;
  };

  $scope.showModal = function () {
    var modalInstance = $modal.open({
      templateUrl: 'confirmationDialog',
      controller: "CampaignConfirmationCtrl",
      resolve: {
        campaign: function() {
          return $scope.campaign;
        },
      } //resolve
    }); //$modal.open

    modalInstance.result.then(function () {
      //They pressed OK
      $scope.campaign.$deliver()

    }, function () {
      //They pressed cancel
    });
  }
}]);


emailer.controller("CampaignConfirmationCtrl", ["$scope", "$modalInstance", "campaign", function CampaignConfirmationCtrl ($scope, $modalInstance, campaign) {
  $scope.campaign = campaign;

  $scope.ok = function () {
    $modalInstance.close();
  };

  $scope.cancel = function () {
    $modalInstance.dismiss('cancel');
  };
}]);
