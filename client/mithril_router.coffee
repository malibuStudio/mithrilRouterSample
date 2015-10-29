Meteor.startup ->
  fadesIn = (element, isInitialized)->
    console.log "fadesIn init:#{isInitialized}"
    unless isInitialized
      TweenLite.fromTo element, 0.5,
        opacity: 0
      ,
        opactiy: 1
        onComplete: ->
          console.log 'fadesIn onComplete'
          element.style.opacity = 1
  fadesOutPage = (element, isInitialized)->
    console.log "fadesOutPage init:#{isInitialized}"
    unless isInitialized
      element.onclick = (e)->
        e.preventDefault()
        TweenLite.fromTo "#container", 0.5,
          opactiy: 1
        ,
          opacity: 0
          onComplete: ->
            m.route element.getAttribute 'href'
  Home =
    controller: ->
      onunload: ->
        console.log "unloading home component"
    view: ->
      m "#container", config: fadesIn, [
        m "div#login", config: (element, isInitiated)->
          Blaze.render Template.loginButtons, element
        m "div", "home"
        m "a[href=/dashboard]", config: fadesOutPage, "to Dashboard"
      ]
  
  Dashboard =
    controller: ->
    view: ->
      m "#container", config: fadesIn, [
        m "div", "dashboard"
        m "a[href=/]", config: fadesOutPage, "to home"
      ]
  
  m.route.mode = "pathname"
  m.route document.body, "/",
    "/": Home
    "/dashboard": Dashboard
