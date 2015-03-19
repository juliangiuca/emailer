var emailer = angular.module('emailer', ['ngResource', 'ui.router', 'ngSanitize', 'ngCookies', 'ui.bootstrap', 'ui.bootstrap.modal', 'textAngular', 'xeditable' ]);

//edit in place
emailer.run(function(editableOptions) {
  editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
});

emailer.run(function($rootScope) {

  $rootScope.$on('$stateChangeStart',
    function(event, toState, toParams, fromState, fromParams){
      console.log('Sending to Mixpanel');
      mixpanel.track(toState.name);
    });

});
