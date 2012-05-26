define [
  'chaplin'
  'models/navigation'
  'views/navigation_view'
], (Chaplin, Navigation, NavigationView) ->
  'use strict'

  class NavigationController extends Chaplin.Controller

    initialize: ->
      super
      #console.debug 'NavigationController#initialize'
      @navigation = new Navigation()
      @view = new NavigationView model: @navigation
