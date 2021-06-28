Darkswarm.controller "LegalController", ($scope, $http, $log) ->
  $http.get('https://www.distracted-driscoll.135-125-232-65.plesk.page/wp-json/wp/v2/pages/463').success (content) ->
    $scope.title = content.title
    $scope.content = content.content
