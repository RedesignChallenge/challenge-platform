(function() {
  'use strict';

  describe('ChallengePlatform', function () {
    var actualDuScrollDuration,
        actualDuScrollOffset;

    beforeEach(function () {
      module('ChallengePlatform');
      inject(function (_duScrollDuration_, _duScrollOffset_) {
        actualDuScrollDuration = _duScrollDuration_;
        actualDuScrollOffset = _duScrollOffset_;
      });
    });

    it('has a duScrollDuration set to 1000', function () {
      expect(actualDuScrollDuration).toEqual(1000);
    });

    it('has a duScrollOffset value of 30', function () {
      expect(actualDuScrollOffset).toEqual(30);
    });
  });
})();