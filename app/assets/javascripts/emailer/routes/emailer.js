emailer.config(['$routeProvider', function ($routeProvider) {
  $routeProvider.
    when('/campaigns/:campaignId', {
      templateUrl: 'ngViews/campaigns/show',
      //controller: 'CampaignShowCtrl',
    }).
    when('/campaigns', {
      templateUrl: 'ngViews/campaigns/index',
      controller: 'CampaignCtrl',
    }).
    when('/users', {
      templateUrl: 'ngViews/users/index',
      controller: 'UserCtrl'
    }).
    when('/emails/new', {
      templateUrl: 'ngViews/emails/new',
      controller: 'EmailsNewCtrl'
    }).
    when('/emails/:emailId', {
      templateUrl: 'ngViews/emails/show',
      controller: 'EmailsShowCtrl'
    }).
    when('/groups', {
      templateUrl: 'ngViews/groups/index',
      controller: 'GroupsIndexCtrl'
    }).
    when('/groups/new', {
      templateUrl: 'ngViews/groups/new',
      controller: 'GroupsShowCtrl'
    }).
    when('/groups/:groupId', {
      templateUrl: 'ngViews/groups/show',
      controller: 'GroupsShowCtrl'
    }).
    otherwise({
      redirectTo: '/emails/new'
    });
}])
