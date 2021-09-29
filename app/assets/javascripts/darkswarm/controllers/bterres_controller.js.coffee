Darkswarm.controller "BTerresController", ($scope, $http, $log) ->

  console.log 'JS Loaded'

  btnarray = []
  carray = []
  x = document.getElementById('lang').textContent
  $http.get('https://gestor.campviu.cat/wp-json/wp/v2/pages/213').success (content) ->
    $scope.content = content.acf["ca"]
    #Carreguem la informació de cada block a les variables per ser utilitzades posteriorment.
    array = Object.values($scope.content.normal_block)
    $scope.normal_block_1 = JSON.parse(JSON.stringify(array[0]))
    $scope.normal_block_2 = JSON.parse(JSON.stringify(array[1]))

  $scope.toggleBTContract = ->
    a = event.currentTarget #Botó
    id = a.dataset.contract #ID del contenidor
    tmp = "contract" + id + "_container"

    b = document.getElementById(tmp) #Seleccionem el contenidor que volem desplegar

    contractes = $scope.content.contracts
    value = Object.keys(contractes.contracte).length
    i = 0

    while i < value
      containerstr = "contract" + i + "_container"
      container = document.getElementById(containerstr)
      hideContract(container)
      i++
    b.classList.add "active"
    b.classList.remove "hidden"

  hideContract = (container) ->
    if container.classList.contains "active"
      container.classList.add "hidden"
      container.classList.remove "active"
