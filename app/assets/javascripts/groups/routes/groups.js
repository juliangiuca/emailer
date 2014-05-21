groups.config(['$stateProvider', '$urlRouterProvider', function ($stateProvider, $urlRouterProvider) {

  var fetchGroup = {

    preFetched: ["$http", "$stateParams", function ($http, $stateParams) {
      var data = {};

      var saveResourceData = function(scoped) {
        return function(response) {
          data[scoped] = response.data
        }
      }

      return $http.get("/api/v1/groups/" + $stateParams.groupId)
        .then(saveResourceData('group'))
        .then(function() {
          return data;
        })
    }]
  }

  $stateProvider
    .state('index', {
      url: "/",
      templateUrl: '/ngViews/groups/index',
      controller: 'GroupsIndexCtrl'
    })
    .state('showGroup', {
      url: '/:groupId',
      data: {name: "list"},
      templateUrl: '/ngViews/groups/show',
      controller: 'GroupsShowCtrl',
      resolve: fetchGroup
    })
      .state('showGroup.bulkAdd', {
        data: {name: "bulkAdd"},
        url: '/bulk',
      })

    $urlRouterProvider.otherwise('/');
}])
