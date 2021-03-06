define [
  'underscore'
  'chaplin'
  'models/base/collection'
  'models/post'
], (_, Chaplin, Collection, Post) ->
  'use strict'

  class Posts extends Collection

    # Mix in a SyncMachine
    _.extend @prototype, Chaplin.SyncMachine

    model: Post

    initialize: ->
      super

      @subscribeEvent 'login', @fetch
      @subscribeEvent 'logout', @logout

      @fetch()

    # Custom fetch function since the Facebook graph is not
    # a REST/JSON API which might be accessed using Ajax
    fetch: =>
      #console.debug 'Posts#fetch'

      user = Chaplin.mediator.user
      return unless user

      facebook = user.get 'provider'
      return unless facebook.name is 'facebook'

      # Switch to syncing state
      @beginSync()

      facebook.getInfo '/158352134203230/feed', @processPosts

    processPosts: (response) =>
      #console.debug 'Posts#processPosts', response, response.data
      return if @disposed

      posts = if response and response.data then response.data else []

      # Only show posts from moviepilot.com
      posts = _(posts).filter (post) ->
        post.from and post.from.name is 'moviepilot.com'

      # Update the collection
      @reset posts

      # Switch to synced state
      @finishSync()

    # Handler for the global logout event
    logout: =>
      # Empty the collection
      @reset()

      # Return to unsynced state
      @unsync()
