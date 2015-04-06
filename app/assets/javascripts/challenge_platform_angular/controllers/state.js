app.controller('StateCtrl', function($scope) {
  $scope.userOptions = {
    allowClear: true,
    multiple: true,
    placeholder: "Please select your state",
    ajax: {
      url: "/states/search.json",
      data: function (term) {
        return { search: term };
      },
      results: function (data) {
        return {
          results: _.map(data.states, function(state){
            return{ id: state.id, text: state.name + ' (' + state.mail_state + ')' }
          })
        }
      }
    },
    initSelection : function (element, callback) {
      var data = [];
      _.each($scope.user_states_json, function(state){
        data.push({id: state.id, text: state.name + ' (' + state.mail_state + ')'});
      });
      callback(data);
    }
  };
});