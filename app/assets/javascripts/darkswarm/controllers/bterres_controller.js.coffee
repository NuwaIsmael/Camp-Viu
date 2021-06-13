Darkswarm.controller "BTerresController", ($scope, $http, $log) ->


  btnarray = []
  carray = []
  x = document.getElementById('lang').textContent
  $http.get('https://www.distracted-driscoll.135-125-232-65.plesk.page/wp-json/wp/v2/pages/213').success (content) ->
    $scope.content = content.acf["ca"]
    #Carreguem la informació de cada block a les variables per ser utilitzades posteriorment.
    array = Object.values($scope.content.normal_block)
    $scope.normal_block_1 = JSON.parse(JSON.stringify(array[0]))
    $scope.normal_block_2 = JSON.parse(JSON.stringify(array[1]))
    window.onload = ->
      contractes = $scope.content.contracts
      value = Object.keys(contractes.contracte).length
      i = 0
      while i < value
        btnstr = "contract" + i + "_btn"
        containerstr = "contract" + i + "_container"
        btnarray[i] = document.getElementById(btnstr)
        carray[i] = document.getElementById(containerstr)
        val = i
        addClickHandler btnarray[i], carray[i]
        i++

  addClickHandler = (button, div) ->
    button.addEventListener 'click', ->
      div.classList.toggle 'hidden'
      div.classList.toggle 'active'
