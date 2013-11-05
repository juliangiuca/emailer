emailer.config(['$routeProvider', function ($routeProvider) {
  $routeProvider.
    when('/campaigns/:campaignId', {
      templateUrl: 'ngView/campaigns/show',
      //controller: 'CampaignShowCtrl',
    }).
    when('/campaigns', {
      templateUrl: 'ngView/campaigns/index',
      controller: 'CampaignCtrl',
    }).
    when('/users', {
      templateUrl: 'ngView/users/index',
      controller: 'UserCtrl'
    })
    //when('/campaigns/new', {
    //}).
    //otherwise({
      //redirectTo: '/campaigns'
    //});
}])
