var challenge_platform_js = challenge_platform_js || {};

(function() {
  'use strict';

  $(function() {
    challenge_platform_js.invokeBootstrapSwitch();
  });

  challenge_platform_js.invokeBootstrapSwitch = function invokeBootstrapSwitch() {
    $('.radio-switch').bootstrapSwitch();
  };
})();
