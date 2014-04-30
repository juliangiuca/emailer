groups.config(['$routeProvider', function ($routeProvider) {
  $routeProvider.
    when('/', {
      templateUrl: 'ngViews/groups/index',
      controller: 'GroupsIndexCtrl'
    }).
    when('/new', {
      templateUrl: 'ngViews/groups/new',
      controller: 'GroupsShowCtrl'
    }).
    when('/:groupId', {
      templateUrl: 'ngViews/groups/show',
      controller: 'GroupsShowCtrl'
    }).
    otherwise({
      redirectTo: '/'
    });
}])
