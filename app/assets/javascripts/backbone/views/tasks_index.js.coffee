class Shuff.Views.TasksIndex extends Backbone.View
  template: JST["backbone/templates/tasks/index"]

  render: ->
    $(@el).html(@template({ tasks: @collection }))
    return this
