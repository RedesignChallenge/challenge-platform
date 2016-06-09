(function() {
  'use strict';

  describe('ideas_example.js', function () {
    describe('on load', function () {
      beforeEach(function () {
        spyOn($.fn, 'popover');
        invokePopover();
      });

      it('invokes popover', function () {
        expect($.fn.popover).toHaveBeenCalled();
      });
    });
  });
})();