(function() {
  'use strict';

  describe('account.js', function () {
    describe('on load', function () {
      beforeEach(function () {
        spyOn($.fn, 'bootstrapSwitch');
        invokeBootstrapSwitch();
      });

      it('invokes bootstrapSwitch', function () {
        expect($.fn.bootstrapSwitch).toHaveBeenCalled();
      });
    });
  });
})();