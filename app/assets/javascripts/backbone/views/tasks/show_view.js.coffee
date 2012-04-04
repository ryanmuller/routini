Shuff.Views.Tasks ||= {}

class Shuff.Views.Tasks.ShowView extends Backbone.View
  template: JST["backbone/templates/tasks/show"]
  
  renderTask: ->
    @$('#task-description').text(@model.get('description'))
  
  render: ->
    $(@el).html(@template())
    @renderTask()
    return this
