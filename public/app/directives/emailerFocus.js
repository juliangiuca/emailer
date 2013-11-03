emailer.directive('emailerFocus', function emailerFocus($timeout) {
  return function (scope, elem, attrs) {
    scope.$watch(attrs.emailerFocus, function (newVal) {
      if (newVal) {
        $timeout(function () {
          elem[0].focus();
        }, 0, false);
      }
    });
  };
});
