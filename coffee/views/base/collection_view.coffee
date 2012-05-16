define [
  'chaplin',
  'views/base/view'
], (Chaplin, View) ->
  'use strict'

  class CollectionView extends Chaplin.CollectionView

    # Borrow the method from the View prototype
    getTemplateFunction: View::getTemplateFunction
