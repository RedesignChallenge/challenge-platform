app.controller('DistrictCtrl', function($scope) {
  $scope.userOptions = {
    allowClear: true,
    multiple: true,
    placeholder: "Please select your district",
    ajax: {
      url: "/districts/search.json",
      data: function (term) {
        return { search: term };
      },
      results: function (data) {
        return {
          results: _.map(data.districts, function(district){
            return{ id: district.id, text: district.name + ' (' + district.location_city + ', ' + district.location_state + ')' }
          })
        }
      }
    },
    initSelection : function (element, callback) {
      var data = [];
      _.each($scope.user_districts_json, function(district){
        data.push({id: district.id, text: district.name + ' (' + district.location_city + ', ' + district.location_state + ')'});
      });
      callback(data);
    }
  };
});