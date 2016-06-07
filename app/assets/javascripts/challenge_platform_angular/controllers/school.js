(function () {
  'use strict';

  angular
    .module('ChallengePlatformApp')
    .controller('SchoolCtrl', SchoolCtrl);

  SchoolCtrl.$inject = [
    '$scope'
  ];

  function SchoolCtrl($scope) {
    $scope.userOptions = {
      allowClear: true,
      multiple: true,
      placeholder: "Please select your school",
      ajax: {
        url: "/schools/search.json",
        data: function (term) {
          return {search: term};
        },
        results: function (data) {
          return {
            results: _.map(data.schools, function (school) {
              return {
                id: school.id,
                text: school.name + ' (' + school.location_city + ', ' + school.location_state + ')'
              }
            })
          }
        }
      },
      initSelection: function (element, callback) {
        var data = [];
        _.each($scope.user_schools_json, function (school) {
          data.push({
            id: school.id,
            text: school.name + ' (' + school.location_city + ', ' + school.location_state + ')'
          });
        });
        callback(data);
      }
    };
  }
})();