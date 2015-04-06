app.controller('ChallengeCtrl', function($scope) {
  $scope.challenge = Challenge.get({id: $scope.id});
});