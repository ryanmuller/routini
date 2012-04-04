Shuff.Views.Tasks ||= {}

class Shuff.Views.Tasks.IndexView extends Backbone.View
  template: JST["backbone/templates/tasks/index"]

  render: ->
    $(@el).html(@template({ tasks: @collection }))
    return this
