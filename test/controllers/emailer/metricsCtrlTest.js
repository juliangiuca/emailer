describe('emailer', function () {
  var scope, controller;

  beforeEach(function () {
    module('emailer');
  });

  describe('metricsCtrl', function () {
    beforeEach(inject(function ($rootScope, $controller) {

      scope = $rootScope.$new();

      controller = $controller('metricsCtrl', {
        '$scope': scope
      });
    }));

    it('sets the name', function () {
      expect(scope.opened).toEqual(new Array);
    });

  });
});
