Routini.Views.Situations ||= {}

class Routini.Views.Situations.ShowView extends Backbone.View
  template: JST["backbone/templates/situations/show"]

  render: ->
    $(@el).html(@template())
    return this
