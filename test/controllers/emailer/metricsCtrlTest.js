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
      scope.recipients = [recipient.read, recipient.unread, recipient.unopened]

      controller = $controller('metricsCtrl', {
        '$scope': scope
      });
    }));

    it('find the open emails', function () {
      expect(scope.opened).toEqual([recipient.read]);
    });

    it('find the unopen emails', function () {
      expect(scope.unopened).toEqual([recipient.unread]);
    });

    it('find the unsent emails', function () {
      expect(scope.unsent).toEqual([recipient.unopened]);
    });

  });
});
