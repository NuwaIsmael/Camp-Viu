module = angular.module("demo", ['ui.gravatar'])

Darkswarm.controller "FaqController", ($scope, $http, $log) ->
  x = document.getElementById('lang').textContent
  $http.get('https://www.distracted-driscoll.135-125-232-65.plesk.page/wp-json/wp/v2/pages/8').success (posts) ->
    console.log posts
    $scope.posts = posts.acf["ca"].faq

  window.onload = ->
    acc = document.getElementsByClassName('accordion')
    i = undefined
    i = 0
    while i < acc.length
      acc[i].addEventListener 'click', ->
        ### Toggle between adding and removing the "active" class,
        to highlight the button that controls the panel
        ###

        @classList.toggle 'active'

        ### Toggle between hiding and showing the active panel ###

        panel = @nextElementSibling
        panel.classList.toggle 'hidden'
        return
      i++

    # ---
    # generated by js2coffee 2.2.0
