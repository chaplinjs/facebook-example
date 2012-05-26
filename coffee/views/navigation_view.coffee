define [
  'views/base/view'
  'text!templates/navigation.hbs'
], (View, template) ->
  'use strict'

  class NavigationView extends View

    # Save the template string in a prototype property.
    # This is overwritten with the compiled template function.
    # In the end you might want to used precompiled templates.
    template: template
    template = null

    id: 'navigation'
    # Automatically append to the DOM on render
    container: '#navigation-container'
    # Automatically render after initialize
    autoRender: true

    initialize: ->
      super
      #console.debug 'NavigationView#initialize'
      @subscribeEvent 'startupController', @render
