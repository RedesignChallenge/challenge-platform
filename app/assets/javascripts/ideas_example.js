(function () {
  'use strict';

  $(function () {
    invokePopover();
  });
})();

var invokePopover = function () {
  $('[data-toggle="popover"]').popover();
};