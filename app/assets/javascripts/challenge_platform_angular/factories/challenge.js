app.factory("Challenge", function($resource) {
  return $resource("/challenges/:id.json", {id: "@id"});
});