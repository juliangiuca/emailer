contacts.config(['$routeProvider', function ($routeProvider) {
  $routeProvider.
    when('/campaigns/:campaignId', {
      templateUrl: 'ngViews/campaigns/show',
      //controller: 'CampaignShowCtrl',
    }).
    when('/campaigns', {
      templateUrl: 'ngViews/campaigns/index',
      controller: 'CampaignCtrl',
    }).
    when('/contacts', {
      templateUrl: 'ngViews/users/index',
      controller: 'UserCtrl'
    }).
    otherwise({
      redirectTo: '/contacts'
    });
}])
