define [
  'chaplin',
  'views/application_view'
], (Chaplin, ApplicationView) ->
  'use strict'

  class CollectionView extends Chaplin.CollectionView

    # Borrow the method from the View prototype
    getTemplateFunction: ApplicationView::getTemplateFunction
