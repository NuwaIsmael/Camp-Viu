Darkswarm.controller "TutorialsController", ($scope, $http, $log) ->

  x = document.getElementById('lang').textContent
  $http.get('https://gestor.campviu.cat/wp-json/wp/v2/pages/390').success (content) ->
    # $scope.content = content.acf["ca"]

    #Carreguem la informació de cada block a les variables per ser utilitzades posteriorment.

    # array = Object.values($scope.content
    $scope.title = content.title
    $scope.content = content.content
    # $scope.normal_block_2 = JSON.parse(JSON.stringify(array[1]))
