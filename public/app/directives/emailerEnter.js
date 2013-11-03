emailer.directive('emailerEnter', function() {
  return function(scope, element, attrs) {
    element.bind("keydown keypress blur", function(event) {
      if(scope.editing && (event.which === 13 || event.type === 'blur')) {
        scope.$apply(function(){
          scope.$eval(attrs.emailerEnter);
        });

        event.preventDefault();
      }

    });
  };
});
