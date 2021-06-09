Darkswarm.controller "PMarketController", ($scope, $http, $log) ->

  console.log 'JS Loaded'

  x = document.getElementById('lang').textContent
  $http.get('https://www.distracted-driscoll.135-125-232-65.plesk.page/wp-json/wp/v2/pages/44').success (content) ->
    $scope.content = content.acf[x]
    #Carreguem la informació de cada block a les variables per ser utilitzades posteriorment.

    array = Object.values($scope.content.normal_block)
    $scope.normal_block_1 = JSON.parse(JSON.stringify(array[0]))
    $scope.normal_block_2 = JSON.parse(JSON.stringify(array[1]))

    array = Object.values($scope.content.producers_block.icones)
    $scope.producers_block_icon1 = JSON.parse(JSON.stringify(array[0]))
    $scope.producers_block_icon2 = JSON.parse(JSON.stringify(array[1]))
    $scope.producers_block_icon3 = JSON.parse(JSON.stringify(array[2]))

    array = Object.values($scope.content.shop_online_block.enllac)
    $scope.shop_online_block_link1 = JSON.parse(JSON.stringify(array[0]))
    $scope.shop_online_block_link2 = JSON.parse(JSON.stringify(array[1]))
    $scope.shop_online_block_link3 = JSON.parse(JSON.stringify(array[2]))

    $scope.esdeveniments = content.acf.calendari.event

    openCalendarBtn = document.getElementById('pmarket_calendar_open')
    closeCalendarBtn = document.getElementById('pmarket_calendar_close')
    calendar = document.getElementById('pmarket_calendar')

    closeCalendarBtn.addEventListener 'click', ->
      calendar.classList.add 'hidden'

    openCalendarBtn.addEventListener 'click', ->
        calendar.classList.remove 'hidden'

    map2 = undefined

    map2 = new (google.maps.Map)(document.getElementById('map2'),
      center:
        lat: 41.2137005
        lng: 1.1412993
      zoom: 8)

    $scope.esdeveniments.forEach (item) ->
      myLatlng = new (google.maps.LatLng)(item.ubicacio.lat, item.ubicacio.lng)

      marker = new (google.maps.Marker)(
        position: myLatlng
        title: item.lloc)

      marker.setMap(map2);


  console.log 'JS Loaded'
