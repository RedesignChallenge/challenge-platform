(function () {
  'use strict';

  angular
    .module('ChallengePlatform',
      ['ngSanitize',
        'ngResource',
        'ngAnimate',
        'duScroll',
        'ngFitText']);

  angular
    .module('ChallengePlatform')
    .value('duScrollDuration', 1000)
    .value('duScrollOffset', 30);
})();

