var emailer = angular.module('emailer', ['ngResource', 'ui.router', 'ngSanitize', 'ngCookies', 'ui.bootstrap', 'ui.bootstrap.modal', 'textAngular', 'xeditable', 'highcharts-ng']);

emailer.run(function(editableOptions) {
  editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
});
