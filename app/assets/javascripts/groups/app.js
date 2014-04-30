var groups = angular.module('groups', ['ngResource', 'ngRoute', 'ngSanitize', 'ngCookies', 'ui.bootstrap', 'ui.bootstrap.modal', 'xeditable']);

groups.run(function(editableOptions) {
  editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
});
