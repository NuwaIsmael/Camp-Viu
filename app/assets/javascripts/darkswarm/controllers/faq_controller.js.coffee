Darkswarm.controller "FaqController", ($scope, $http, $log) ->
  x = document.getElementById('lang').textContent
  $http.get('https://www.distracted-driscoll.135-125-232-65.plesk.page/wp-json/wp/v2/pages/8').success (posts) ->
    $scope.posts = posts.acf["ca"].faq
    acc = []
    acc = document.getElementsByClassName('accordion')
    window.onload = ->
      console.log acc
      i = 0
      console.log acc.length
      while i < acc.length
        panel = acc[i].nextElementSibling
        addClickHandler acc[i], panel
        console.log acc[i] + " / " + panel
        console.log "Hem afegit el handler" + i
        i++

  addClickHandler = (a, b) ->
    a.addEventListener 'click', ->
      b.classList.toggle 'hidden'
      b.classList.toggle 'active'
      console.log a


    # ---
    # generated by js2coffee 2.2.0
