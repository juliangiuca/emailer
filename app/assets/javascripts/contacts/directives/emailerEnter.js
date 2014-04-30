emailer.directive('emailerEnter', function() {
  return function(scope, element, attrs) {
    element.bind("keydown keypress blur", function(event) {
      if(event.which === 13 || event.type === 'blur') {
        console.log("Enter pressed, or focus lost");
        scope.$apply(function(){
          scope.$eval(attrs.emailerEnter);
        });

        event.preventDefault();
      }

    });
  };
});
