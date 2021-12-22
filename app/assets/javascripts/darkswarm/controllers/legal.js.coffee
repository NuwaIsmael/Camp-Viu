Darkswarm.controller "LegalController", ($scope, $http, $log) ->
  $http.get('https://gestor.campviu.cat/wp-json/wp/v2/pages/463').success (content) ->
    $scope.title = content.title
    $scope.content = content.content
