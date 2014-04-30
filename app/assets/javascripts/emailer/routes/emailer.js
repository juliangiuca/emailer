emailer.config(['$routeProvider', function ($routeProvider) {
  $routeProvider.
    when('/new', {
      templateUrl: 'ngViews/emails/new',
      controller: 'EmailsNewCtrl'
    }).
    when('/:emailId', {
      templateUrl: 'ngViews/emails/show',
      controller: 'EmailsShowCtrl',
      resolve: {


        preFetched: ["$http", "$route", function ($http, $route){
          var data = {};

          var saveResourceData = function (scoped) {
            return function(response) {
              return data[scoped] = response.data;
            }
          };

          return $http.get("/api/v1/emails/" + $route.current.params.emailId)
            .then(saveResourceData('email'))
            .then(function() { return $http.get("/api/v1/emails/" + $route.current.params.emailId + "/recipients")} )
            .then(saveResourceData('recipients'))
            .then(function() {
              return data
            })
        }]
      }
    }).
    otherwise({
      redirectTo: '/new'
    });
}])
