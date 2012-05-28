define [
  'chaplin'
  'models/posts'
  'views/posts_view'
], (Chaplin, Posts, PostsView) ->
  'use strict'

  class PostsController extends Chaplin.Controller

    title: 'Facebook Wall Posts'
    historyURL: 'posts'

    index: (params) ->
      #console.debug 'PostsController#index'
      @posts = new Posts()
      @view = new PostsView collection: @posts
