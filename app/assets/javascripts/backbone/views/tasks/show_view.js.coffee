Shuff.Views.Tasks ||= {}

class Shuff.Views.Tasks.ShowView extends Backbone.View
  template: JST["backbone/templates/tasks/show"]

  initialize: () ->
    @model = new Shuff.Models.Task

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this
