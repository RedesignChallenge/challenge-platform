var challenge_platform_js = challenge_platform_js || {};

(function () {
  'use strict';

  $(function () {
    challenge_platform_js.invokePopover();
  });


  challenge_platform_js.invokePopover = function invokePopover () {
    $('[data-toggle="popover"]').popover();
  };
})();
