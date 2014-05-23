var groups = angular.module('groups', ['ngResource', 'ui.router', 'ngSanitize', 'ngCookies', 'ui.bootstrap', 'ui.bootstrap.modal', 'xeditable']);

//In place edit
groups.run(function(editableOptions) {
  editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
});
