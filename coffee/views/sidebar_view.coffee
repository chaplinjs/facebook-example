define [
  'chaplin'
  'views/base/view'
  'text!templates/sidebar.hbs'
], (Chaplin, View, template) ->
  'use strict'

  # Shortcut to the mediator
  mediator = Chaplin.mediator

  class SidebarView extends View

    # Save the template string in a prototype property.
    # This is overwritten with the compiled template function.
    # In the end you might want to used precompiled templates.
    template: template
    template = null

    id: 'sidebar'
    # Automatically append to the DOM on render
    container: '#sidebar-container'
    # Automatically render after initialize
    autoRender: true

    initialize: ->
      super

      @subscribeEvent 'loginStatus', @loginStatusHandler
      @subscribeEvent 'userData', @render

      @delegate 'click', '#logout-button', @logoutButtonClick

    loginStatusHandler: (loggedIn) =>
      #console.debug 'SidebarView#loginStatusHandler', loggedIn
      if loggedIn
        @model = mediator.user
      else
        @model = null
      @render()

    # Handle clicks on the logout button
    logoutButtonClick: (event) ->
      event.preventDefault()
      # Publish a global !logout event
      mediator.publish '!logout'
