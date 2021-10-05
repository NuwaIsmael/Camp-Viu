Darkswarm.controller "FaqController", ($scope, $http, $log) ->
  x = document.getElementById('lang').textContent
  $http.get('https://gestor.campviu.cat/wp-json/wp/v2/pages/8').success (posts) ->
    $scope.posts = posts.acf[x].faq
    $scope.posts_mdp = posts.acf[x].faq_mdp
    $scope.posts_bdr = posts.acf[x].faq_bdr

  $scope.triggerAccordion = ->
    a = event.currentTarget
    b = a.nextElementSibling
    b.classList.toggle 'hidden'
    b.classList.toggle 'active'
