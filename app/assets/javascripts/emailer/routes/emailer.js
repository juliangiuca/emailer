emailer.config(['$routeProvider', function ($routeProvider) {
  $routeProvider.
    when('/new', {
      templateUrl: 'ngViews/emails/new',
      controller: 'EmailsNewCtrl'
    }).
    when('/:emailId', {
      templateUrl: 'ngViews/emails/show',
      controller: 'EmailsShowCtrl'
    }).
    otherwise({
      redirectTo: '/new'
    });
}])
