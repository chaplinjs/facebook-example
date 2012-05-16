define [
  'chaplin'
  'views/layout'
  'controllers/session_controller'
  'controllers/navigation_controller'
  'controllers/sidebar_controller'
  'routes'
], (Chaplin, Layout, SessionController, NavigationController, SidebarController, routes) ->
  'use strict'

  # The application object
  class FacebookApplication extends Chaplin.Application

    # Set your application name here so the document title is set to
    # “Controller title – Site title” (see Layout#adjustTitle)
    title: 'Chaplin Example Application with Facebook login'

    initialize: ->
      super
      #console.debug 'FacebookApplication#initialize'

      # Initialize core components
      @initDispatcher()
      @initLayout()
      @initMediator()

      # Application-specific scaffold
      @initControllers()

      # Register all routes and start routing
      @initRouter routes

      # Freeze the application instance to prevent further changes
      Object.freeze? this

    # Override standard layout initializer
    # ------------------------------------
    initLayout: ->
      @layout = new Layout {@title}

    # Instantiate common controllers
    # ------------------------------
    initControllers: ->
      # These controllers are active during the whole application runtime.
      new SessionController()
      new NavigationController()
      new SidebarController()

    # Create aditional mediator properties
    # ------------------------------------
    initMediator: ->
      # Create a user property
      Chaplin.mediator.user = null
      # Seal the mediator
      Chaplin.mediator.seal()
