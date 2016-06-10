(function() {
  'use strict';

  describe('account.js', function () {
    describe('on load', function () {
      beforeEach(function () {
        spyOn($.fn, 'bootstrapSwitch');
        challenge_platform_js.invokeBootstrapSwitch();
      });

      it('invokes bootstrapSwitch', function () {
        expect($.fn.bootstrapSwitch).toHaveBeenCalled();
      });
    });
  });
})();