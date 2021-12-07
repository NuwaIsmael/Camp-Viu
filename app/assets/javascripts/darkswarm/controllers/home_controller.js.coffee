Darkswarm.controller "HomeCtrl", ($scope, $http, $sce) ->
  $scope.brandStoryExpanded = false

  $scope.toggleBrandStory = ->
    $scope.brandStoryExpanded = !$scope.brandStoryExpanded

  x = document.getElementById('lang').textContent

  _headers = new Headers('Content-Type': 'application/json')
  _headers.append 'Authorization', '8Kv9TGtWm3t7cDYydCYyHH3B'
  values = $http.get('https://comunitat.campviu.cat/api/stats?contracts=100', headers:_headers)

  console.log values
  $http.get('https://gestor.campviu.cat/wp-json/wp/v2/pages/5').success (content) ->
    $scope.content = content.acf[x]
    #Carreguem la informació de cada block a les variables per ser utilitzades posteriorment.
    array = Object.values($scope.content.block)
    $scope.home_block_1 = JSON.parse(JSON.stringify(array[0]))
    $scope.home_block_2 = JSON.parse(JSON.stringify(array[1]))
    $scope.home_block_3 = JSON.parse(JSON.stringify(array[2]))

    #Icones del block 1
    array2 = Object.values($scope.home_block_1.icones)
    $scope.home_block_1_icon1 = JSON.parse(JSON.stringify(array2[0]))
    $scope.home_block_1_icon2 = JSON.parse(JSON.stringify(array2[1]))
    $scope.home_block_1_icon3 = JSON.parse(JSON.stringify(array2[2]))

    #Icones del block 2
    array2 = Object.values($scope.home_block_2.icones)
    $scope.home_block_2_icon1 = JSON.parse(JSON.stringify(array2[0]))
    $scope.home_block_2_icon2 = JSON.parse(JSON.stringify(array2[1]))
    $scope.home_block_2_icon3 = JSON.parse(JSON.stringify(array2[2]))
    $scope.home_block_2_icon4 = JSON.parse(JSON.stringify(array2[3]))

    #Icones del block 3

    array2 = Object.values($scope.home_block_3.icones)
    $scope.home_block_3_icon1 = JSON.parse(JSON.stringify(array2[0]))
    $scope.home_block_3_icon2 = JSON.parse(JSON.stringify(array2[1]))
    $scope.home_block_3_icon3 = JSON.parse(JSON.stringify(array2[2]))
    $scope.home_block_3_icon4 = JSON.parse(JSON.stringify(array2[3]))

    #Brandstory icons
    array = Object.values($scope.content.brandstory.icones)
    $scope.brandstory_icons_1 = JSON.parse(JSON.stringify(array[0]))
    $scope.brandstory_icons_2 = JSON.parse(JSON.stringify(array[1]))
    $scope.brandstory_icons_3 = JSON.parse(JSON.stringify(array[2]))

    #Counter Stats
    array = Object.values($scope.content.contadors.contador)
    $scope.stats1 = JSON.parse(JSON.stringify(array[0]))
    $scope.stats2 = JSON.parse(JSON.stringify(array[1]))
    $scope.stats3 = JSON.parse(JSON.stringify(array[2]))
    $scope.stats4 = JSON.parse(JSON.stringify(array[3]))
    $scope.stats5 = JSON.parse(JSON.stringify(array[4]))


    openBrandstory = document.getElementById('brandstory_expand')
    openBrandstory.addEventListener 'click', ->
      $('#brandstory_expand_container').toggle('hidden')


  $scope.trustSrc = (src) ->
    $sce.trustAsResourceUrl src



# ---
# generated by js2coffee 2.2.0
