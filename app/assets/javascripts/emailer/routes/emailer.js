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
      controller: 'EmailsNewCtrl'
    }).
    when('/emails/:emailId', {
      templateUrl: 'ngView/emails/show',
      controller: 'EmailsShowCtrl'
    }).
    when('/groups', {
      templateUrl: 'ngView/groups/index',
      controller: 'GroupsIndexCtrl'
    }).
    when('/groups/new', {
      templateUrl: 'ngView/groups/new',
      controller: 'GroupsShowCtrl'
    }).
    when('/groups/:groupId', {
      templateUrl: 'ngView/groups/show',
      controller: 'GroupsShowCtrl'
    }).
    otherwise({
      redirectTo: '/emails/new'
    });
}])
