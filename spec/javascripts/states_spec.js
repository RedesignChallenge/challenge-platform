(function() {
  'use strict';

  describe('states.js.erb', function () {
    describe('standard options', function () {
      var testObj = challenge_platform_js.stateSelectOptions;

      it('sets the right width', function () {
        expect(testObj.width).toBe('100%');
      });

      it('sets allowClear to true', function () {
        expect(testObj.allowClear).toBe(true);
      });

      it('sets multiple to true', function () {
        expect(testObj.multiple).toBe(true);
      });

      it('sets minimumInputLength to 1', function () {
        expect(testObj.minimumInputLength).toEqual(1);
      });

      it('sets the placeholder to an English i18n string', function () {
        expect(testObj.placeholder).toBe('Please select your state');
      });

      it('has an ajax method defined', function () {
        expect(testObj.ajax).toBeDefined();
      });
    });

    describe('ajax options', function () {
      var testObj = challenge_platform_js.stateSelectAjaxOptions;

      it('has the right URL', function () {
        expect(testObj.url).toEqual('/states/search.json');
      });

      it('has a processResults method defined', function () {
        expect(testObj.processResults).toBeDefined();
      });

      describe('data function', function () {
        var params = {term: 'foo'};

        it('returns a JSON object with the right structure', function () {
          expect(testObj.data(params)).toEqual({search: 'foo'});
        });
      });
    });

    describe('processResults function', function () {
      var data = [
        {id: 1, name: 'Prime', mail_state: 'XX'},
        {id: 2, name: 'Seven', mail_state: 'YY'},
        {id: 3, name: 'Rhyme', mail_state: 'ZZ'}
      ];

      var actual;
      beforeEach(function () {
        actual = challenge_platform_js.stateSelectProcessFn(data);
      });

      it('returns the data in the right format', function () {
        expect(actual).toEqual(
          {
            results: [
              {id: 1, text: 'Prime (XX)'},
              {id: 2, text: 'Seven (YY)'},
              {id: 3, text: 'Rhyme (ZZ)'}
            ]
          }
        )
      });
    });
  });
})();