contacts.config(['$stateProvider', '$urlRouterProvider',
function ($stateProvider, $urlRouterProvider) {

  $stateProvider
    .state('index', {
      url: "/",
      templateUrl: '/ngViews/contacts/index',
      controller: 'indexCtrl',
    });

  $urlRouterProvider.otherwise('/');
}])
