emailer.config(['$stateProvider', '$urlRouterProvider', function ($stateProvider, $urlRouterProvider) {
  var fetchEmail = {

    //Block and fetch the email we are looking at
    preFetched: ["$http", "$stateParams", function ($http, $stateParams){

      var data = {};

      var saveResourceData = function (scoped) {
        return function(response) {
          return data[scoped] = response.data;
        }
      };

      return $http.get("/api/v1/emails/" + $stateParams.emailId)
        .then(saveResourceData('email'))
        .then(function() { return $http.get("/api/v1/emails/" + $stateParams.emailId + "/recipients")} )
        .then(saveResourceData('recipients'))
        .then(function() {
          return data
        })
    }]
  }

  $stateProvider
    .state('index', {
      url: "/",
      templateUrl: '/ngViews/emails/index',
      controller: 'EmailsIndexCtrl'
    })
    .state('email', {
      url: "/new",
      templateUrl: '/ngViews/emails/new',
      controller: 'EmailsNewCtrl'
    })
    .state('showEmail', {
      url: '/:emailId',
      data: {name: "compose"},
      templateUrl: '/ngViews/emails/show',
      controller: 'EmailsShowCtrl',
      resolve: fetchEmail
    })
      .state('showEmail.metrics', {
        data: {name: "metrics"},
        url: '/metrics',
      })
      .state('showEmail.recipients', {
        data: {name: "recipients"},
        url: '/recipients',
      })

    $urlRouterProvider.otherwise('/');
}])
