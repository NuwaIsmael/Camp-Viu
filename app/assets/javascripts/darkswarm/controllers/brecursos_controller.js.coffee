Darkswarm.controller "BRecursosController", ($scope, $http, $log) ->

  console.log 'JS Loaded'

  x = document.getElementById('lang').textContent
  $http.get('https://www.distracted-driscoll.135-125-232-65.plesk.page/wp-json/wp/v2/pages/274').success (content) ->
    $scope.content = content.acf["ca"]
    #Carreguem la informació de cada block a les variables per ser utilitzades posteriorment.


  $http.get('https://www.distracted-driscoll.135-125-232-65.plesk.page/wp-json/wp/v2/pages/5').success (content2) ->
    $scope.content2 = content2.acf["ca"]

    array = Object.values($scope.content2.block)
    $scope.home_block_3 = JSON.parse(JSON.stringify(array[2]))

    array = Object.values($scope.home_block_3.icones)
    $scope.home_block_3_icon1 = JSON.parse(JSON.stringify(array[0]))
    $scope.home_block_3_icon2 = JSON.parse(JSON.stringify(array[1]))
    $scope.home_block_3_icon3 = JSON.parse(JSON.stringify(array[2]))
    $scope.home_block_3_icon4 = JSON.parse(JSON.stringify(array[3]))
  #
  # array = Object.values($scope.content.producers_block.icones)
  # $scope.producers_block_icon1 = JSON.parse(JSON.stringify(array[0]))
  # $scope.producers_block_icon2 = JSON.parse(JSON.stringify(array[1]))
  # $scope.producers_block_icon3 = JSON.parse(JSON.stringify(array[2]))
  #
  # array = Object.values($scope.content.shop_online_block.enllac)
  # $scope.shop_online_block_link1 = JSON.parse(JSON.stringify(array[0]))
  # $scope.shop_online_block_link2 = JSON.parse(JSON.stringify(array[1]))
  # $scope.shop_online_block_link3 = JSON.parse(JSON.stringify(array[2]))
