(function() {
  'use strict';

  describe('ideas_example.js', function () {
    describe('on load', function () {
      beforeEach(function () {
        spyOn($.fn, 'popover');
        challenge_platform_js.invokePopover();
      }); 

      it('invokes popover', function () {
        expect($.fn.popover).toHaveBeenCalled();
      });
    });
  });
})();