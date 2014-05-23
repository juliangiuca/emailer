var contacts = angular.module('contacts', ['ngResource', 'ui.router', 'ngSanitize', 'ui.bootstrap', 'xeditable']);

//edit in place
contacts.run(function(editableOptions) {
  editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
});
