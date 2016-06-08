(function () {
  'use strict';

  angular
    .module('ChallengePlatform')
    .controller('IdeaCtrl', IdeaCtrl);

  IdeaCtrl.$inject = [
    '$scope',
    '$timeout'
  ];

  function IdeaCtrl($scope, $timeout) {
    $scope.form = true;

    $scope.showExample = function () {
      $scope.form = false;
      $scope.example = true;
      $scope.refinement = false;

      $timeout(function () {
        $(".example-popover").popover('show');
      });
    };

    $scope.showForm = function () {
      $scope.form = true;
      $scope.example = false;
      $scope.refinement = false;

      $timeout(function () {
        $(".example-popover").popover('hide');
      });
    };

    $scope.showRefinement = function () {
      $scope.form = false;
      $scope.example = false;
      $scope.refinement = true;
    };
  }
})();