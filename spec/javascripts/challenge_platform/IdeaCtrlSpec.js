(function () {
  'use strict';

  describe('IdeaCtrl', function () {
    var $scope,
      $timeout;

    beforeEach(function () {
      module('ChallengePlatform');

      inject(function (_$controller_, _$rootScope_, _$timeout_) {
        $scope = _$rootScope_.$new(true);
        $timeout = _$timeout_;
        _$controller_('IdeaCtrl', {
          $scope: $scope,
          $timeout: $timeout
        });
      });
    });

    describe('#showExample', function () {
      beforeEach(function () {
        spyOn($.fn, 'popover');
        $scope.showExample();
        $timeout.flush();
      });

      it('sets form to false', function () {
        expect($scope.form).toBe(false);
      });

      it('sets example to true', function () {
        expect($scope.example).toBe(true);
      });

      it('sets refinement to false', function () {
        expect($scope.refinement).toBe(false);
      });

      it('invokes the show variant of jQuery popover', function () {
        expect($.fn.popover).toHaveBeenCalledWith('show');
      });
    });

    describe('#showForm', function () {
      beforeEach(function () {
        spyOn($.fn, 'popover');
        $scope.showForm();
        $timeout.flush();
      });

      it('sets form to true', function () {
        expect($scope.form).toBe(true);
      });

      it('sets example to false', function () {
        expect($scope.example).toBe(false);
      });

      it('sets refinement to false', function () {
        expect($scope.refinement).toBe(false);
      });

      it('invokes the hide variant of jQuery popover', function () {
        expect($.fn.popover).toHaveBeenCalledWith('hide');
      });
    });

    describe('#showRefinement', function () {
      beforeEach(function () {
        spyOn($.fn, 'popover');
        $scope.showRefinement();
      });

      it('sets form to false', function () {
        expect($scope.form).toBe(false);
      });

      it('sets example to false', function () {
        expect($scope.example).toBe(false);
      });

      it('sets refinement to true', function () {
        expect($scope.refinement).toBe(true);
      });

      it('does not invoke popover', function () {
        expect($.fn.popover).not.toHaveBeenCalled();
      });
    });

  });
})();