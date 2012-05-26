define [
  'underscore'
  'chaplin'
  'lib/utils'
  'views/base/view'
  'text!templates/login.hbs'
], (_, Chaplin, utils, View, template) ->
  'use strict'

  # Shortcut to the mediator
  mediator = Chaplin.mediator

  class LoginView extends View

    # Save the template string in a prototype property.
    # This is overwritten with the compiled template function.
    # In the end you might want to used precompiled templates.
    template: template
    template = null

    id: 'login'
    # Automatically append to the DOM on render
    container: '#sidebar-container'
    # Automatically render after initialize
    autoRender: true

    # Expects the serviceProviders in the options
    initialize: (options) ->
      super
      #console.debug 'LoginView#initialize', @el, options, options.serviceProviders
      @initButtons options.serviceProviders

    # In this project we currently only have one service provider and therefore
    # one button. But this should allow for different service providers.
    initButtons: (serviceProviders) ->
      #console.debug 'LoginView#initButtons', serviceProviders

      for serviceProviderName, serviceProvider of serviceProviders

        buttonSelector = ".#{serviceProviderName}"
        @$(buttonSelector).addClass('service-loading')

        loginHandler = _(@loginWith).bind(
          this, serviceProviderName, serviceProvider
        )
        @delegate 'click', buttonSelector, loginHandler

        loaded = _(@serviceProviderLoaded).bind(
          this, serviceProviderName, serviceProvider
        )
        serviceProvider.done loaded

        failed = _(@serviceProviderFailed).bind(
          this, serviceProviderName, serviceProvider
        )
        serviceProvider.fail failed

    loginWith: (serviceProviderName, serviceProvider, e) ->
      #console.debug 'LoginView#loginWith', serviceProviderName, serviceProvider
      e.preventDefault()
      return unless serviceProvider.isLoaded()
      mediator.publish 'login:pickService', serviceProviderName
      mediator.publish '!login', serviceProviderName

    serviceProviderLoaded: (serviceProviderName) ->
      #console.debug 'LoginView#serviceProviderLoaded', serviceProviderName
      @$(".#{serviceProviderName}").removeClass('service-loading')

    serviceProviderFailed: (serviceProviderName) ->
      #console.debug 'LoginView#serviceProviderFailed', serviceProviderName
      @$(".#{serviceProviderName}")
        .removeClass('service-loading')
        .addClass('service-unavailable')
        .attr('disabled', true)
        .attr('title',
          'Error connecting. Please check whether you are blocking ' +
          "#{utils.upcase(serviceProviderName)}."
        )
