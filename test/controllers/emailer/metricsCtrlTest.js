describe('emailer', function () {
  var scope, controller, recipient;

  beforeEach(function () {
    var fs = require('fs');
    var path = require('path');
    angular.mock.module('emailer');

    recipient = require("../../../test/fixtures/recipient.js");
  });

  describe('metricsCtrl', function () {
    beforeEach(inject(function ($rootScope, $controller) {

      scope = $rootScope.$new();
      scope.recipients = [recipient.liz, recipient.julian]

      controller = $controller('metricsCtrl', {
        '$scope': scope
      });
    }));

    it('sets the name', function () {
      expect(scope.opened).toEqual([recipient.liz]);
    });

  });
});
