emailer.directive('emailerFocus', function emailerFocus($timeout) {
  return {
    scope: { trigger: '=emailerFocus' },
    link: function(scope, element) {
      scope.$watch('trigger', function(value) {
        if(value === true) { 
          //console.log('trigger',value);
          //$timeout(function() {
            element[0].focus();
            //scope.trigger = false;
          //});
        }
      });
    }
  };
});
