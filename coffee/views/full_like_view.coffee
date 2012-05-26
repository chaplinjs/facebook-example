define [
  'chaplin'
  'views/base/view'
  'text!templates/full_like.hbs'
], (Chaplin, View, template) ->
  'use strict'

  class FullLikeView extends View

    # Save the template string in a prototype property.
    # This is overwritten with the compiled template function.
    # In the end you might want to used precompiled templates.
    template: template
    template = null

    id: 'like'
    # Automatically append to the DOM on render
    container: '#content-container'
    # Automatically render after initialize
    autoRender: true

    initialize: ->
      super
      #console.debug 'FullLikeView#initialize'

      # Render again when the model is resolved
      if @model.state() isnt 'resolved'
        @model.done @render

    # Rendering
    render: ->
      super
      #console.debug 'FullLikeView#render'

      # Parse Facebook widgets
      if @model.state() is 'resolved'
        user = Chaplin.mediator.user
        provider = user.get 'provider'
        if provider.name is 'facebook'
          provider.parse @el
