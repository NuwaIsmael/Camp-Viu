Darkswarm.controller "FaqController", ($scope, $http, $log) ->
  x = document.getElementById('lang').textContent
  $http.get('https://www.distracted-driscoll.135-125-232-65.plesk.page/wp-json/wp/v2/pages/8').success (posts) ->
    $scope.posts = posts.acf["ca"].faq


  $scope.triggerAccordion = ->
    a = event.currentTarget
    b = a.nextElementSibling
    b.classList.toggle 'hidden'
    b.classList.toggle 'active'
