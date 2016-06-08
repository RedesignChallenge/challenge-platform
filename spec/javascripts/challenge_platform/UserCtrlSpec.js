(function() {
  'use strict';

  describe('UserCtrl', function () {
    var $scope;

    beforeEach(function () {
      module('ChallengePlatform');

      inject(function (_$rootScope_, _$controller_) {
        $scope = _$rootScope_.$new(true);

        _$controller_('UserCtrl', {
          $scope: $scope
        });
      });
    });

    describe('#otherLEA', function () {
      beforeEach(function () {
        spyOn($scope, 'toggleState');
        $scope.otherLEA('foo');
      });

      it('sets the other_lea property to whatever is passed in', function () {
        expect($scope.other_lea).toEqual('foo');
      });

      it('sets the placeholder to an English I18n string', function () {
        expect($scope.other_placeholder).toEqual('Please type in your District or CMO');
      });

      it('invokes toggleState', function () {
        expect($scope.toggleState).toHaveBeenCalledWith('foo');
      });
    });

    describe('#otherSchool', function () {
      beforeEach(function () {
        spyOn($scope, 'toggleState');
        $scope.otherSchool('cabbages');
      });

      it('sets the other_school property to whatever is passed in', function () {
        expect($scope.other_school).toEqual('cabbages');
      });

      it('sets the placeholder to an English I18n string', function () {
        expect($scope.other_placeholder).toEqual('Please type in your school');
      });

      it('invokes toggleState', function () {
        expect($scope.toggleState).toHaveBeenCalledWith('cabbages');
      });
    });

    describe('#toggleState', function () {
      beforeEach(function () {
        spyOn($.fn, 'hide');
        spyOn($.fn, 'show');
      });

      describe('when isVisible is set to a truthy value', function () {
        beforeEach(function () {
          $scope.toggleState(true);
        });

        it('invokes jQuery hide', function () {
          expect($.fn.hide).toHaveBeenCalled();
        });
      });

      describe('when isVisible is set to a falsy value', function () {
        beforeEach(function () {
          $scope.toggleState(false);
        });

        it('invokes jQuery show', function () {
          expect($.fn.show).toHaveBeenCalled();
        });
      });
    });
  });
})();