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
    }).
    when('/emails/new', {
      templateUrl: 'ngView/emails/new',
      controller: 'NewEmailsCtrl'
    }).
    when('/emails/:emailId', {
      templateUrl: 'ngView/emails/show',
      controller: 'ShowEmailsCtrl'
    }).
    otherwise({
      redirectTo: '/emails/new'
    });
}])
