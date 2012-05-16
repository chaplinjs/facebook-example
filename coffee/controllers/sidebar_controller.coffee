define [
  'chaplin'
  'views/sidebar_view'
], (Chaplin, SidebarView) ->
  'use strict'

  class SidebarController extends Chaplin.Controller

    initialize: ->
      @view = new SidebarView()

