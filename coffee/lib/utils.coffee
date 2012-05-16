define [
  'underscore'
  'jquery'
  'chaplin'
], (_, jquery, Chaplin) ->

  # Application-specific utilities
  # ------------------------------

  # Shortcut to the mediator
  mediator = Chaplin.mediator

  # Delegate to Chaplin’s utils module
  utils = Chaplin.utils.beget Chaplin.utils

  # Add additional application-specific properties and methods

  _(utils).extend

    # Facebook image helper
    # ---------------------

    facebookImageURL: (fbId, type = 'square') ->
      # Create query string
      params = type: type

      # Add the Facebook access token if present
      if mediator.user
        accessToken = mediator.user.get('accessToken')
        params.access_token = accessToken if accessToken

      "https://graph.facebook.com/#{fbId}/picture?#{$.param(params)}"

  utils
