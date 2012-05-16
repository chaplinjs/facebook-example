define [
  'chaplin'
], (Chaplin) ->
  'use strict'

  class Layout extends Chaplin.Layout

    initialize: ->
      super
      @subscribeEvent 'startupController', @removeFallbackContent

    # Fallback content
    # ----------------
    # After the first controller has been started,
    # remove accessible fallback content so the DOM is less complex and images and videos do not lie
    # in the background
    removeFallbackContent: ->
      $('.accessible-fallback').remove()
      # Remove the handler after the first startupController event
      @unsubscribeEvent 'startupController', @removeFallbackContent
