(function () {
  'use strict';

  angular
    .module('ChallengePlatformApp',
      ['ngSanitize',
        'ngResource',
        'ngAnimate',
        'duScroll',
        'ngFitText']);

  angular
    .module('ChallengePlatformApp')
    .value('duScrollDuration', 1000)
    .value('duScrollOffset', 30);
})();

