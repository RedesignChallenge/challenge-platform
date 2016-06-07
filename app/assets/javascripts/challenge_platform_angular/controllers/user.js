(function () {
  'use strict';

  angular
    .module('ChallengePlatformApp')
    .controller('UserCtrl', UserCtrl);

  UserCtrl.$inject = [
    '$scope'
  ];

  function UserCtrl($scope) {
    $scope.otherLEA = function (arg) {
      $scope.other_lea = arg;
      $scope.other_placeholder = 'Please type in your District or CMO';
      arg ? $('.select2-container').hide() : $('.select2-container').show();
    };

    $scope.otherSchool = function (arg) {
      $scope.other_school = arg;
      $scope.other_placeholder = 'Please type in your school';
      arg ? $('.select2-container').hide() : $('.select2-container').show();
    };
  }
})();