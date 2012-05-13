define [
  'chaplin/mediator'
  'chaplin/application'
  'controllers/session_controller'
  'controllers/navigation_controller'
  'controllers/sidebar_controller'
  'routes'
], (mediator, Application, SessionController, NavigationController, SidebarController, routes) ->
  'use strict'

  # The application object
  class FacebookBrowser extends Application

    # Set your application name here so the document title is set to
    # “Controller title – Site title” (see ApplicationView#adjustTitle)
    title: 'Chaplin Example Application with Facebook login'

    initialize: ->
      ###console.debug 'ExampleApplication#initialize'###

      # This creates the ApplicationController and ApplicationView
      super

      @initControllers()
      @initMediator()
      # Register all routes and start routing
      @initRouter routes

    initControllers: ->

      # Instantiate common controllers
      # ------------------------------

      # These controllers are active during the whole application runtime.
      new SessionController()
      new NavigationController()
      new SidebarController()

    # Create aditional mediator properties
    # ------------------------------------

    initMediator: ->
      # Create a user property
      mediator.user = null
      # Seal the mediator
      mediator.seal()

    # Finish
    # ------

    # Freeze the application instance to prevent further changes
    Object.freeze? this
