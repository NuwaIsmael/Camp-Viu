module = angular.module("demo", ['ui.gravatar'])

Darkswarm.controller "FaqController", ($scope, $http, $log) ->

  hidden = d3.map()

  hide = (id)->
    $log.warn("Hiding message", id)
    hidden.set(id, true)

  is_hidden = (id)->
    hidden.get(id) || false

  $log.warn("Hello Wolrd!", $scope)

  conversation = [
    {
      from: "Bill Bryson"
      date: "2015-11-11"
      msg: "Hi Ted, I'm still looking for the sales figures, they should have been with me two weeks ago. What's causing the delay? The conference is two days from now and Brant is getting very worried that we are behind schedule."
      email: "sal@stodge.org"
      id: 253254
      attachments: []
    },
    {
      from: "Ted Danson"
      date: "2015-11-11"
      msg: "Brant aloways gets worked up over this sort of thing. Can you ask him to stay calm for once? I definitely emailed them to you last week. Hae you checked your spam folder? It might have ended up there. Can you use your search button or something? I will have another look when I'm back at my desk."
      email: "wokier@gmail.com"
      id: 123445
      attachments: []
    },
    {
      from: "Bill Bryson"
      date: "2015-11-12"
      msg: "I'm pretty sure it's not in there - I looked twice. Did you actually email it to me? I've recently changed my email address. Brant is literally tearing his hear out - we can hear him from the other side of the building. He's not going to calm down until you ship that report."
      email: "sal@stodge.org"
      id: 123447
      attachments: []
    },
    {
      from: "Ted Danson"
      date: "2015-11-13"
      msg: "Actually I think I sent it to the totally wrong address - here you go!. Check the attachments."
      email: "wokier@gmail.com"
      id: 123419
      attachments: [
        {
          name:"2015 Sales report"
          type:"pdf"
          url:"http://thecompany.com/private/sales.pdf"
        },
        {
          name:"2015 Sales report (appendix 2)"
          type:"html"
          url:"http://thecompany.com/private/sales_appendix2.html"
        },
    ]
    },

  ]

  $scope.is_hidden = is_hidden
  $scope.hide = hide
  $scope.conversation = ()->conversation
  $scope.conversation_title = "Chatting to Ted"

  $http.get('https://www.distracted-driscoll.135-125-232-65.plesk.page/wp-json/wp/v2/pages/8').success (posts) ->
    $scope.posts = posts
