Shuff.Views.Tasks ||= {}

class Shuff.Views.Tasks.ShowView extends Backbone.View
  template: JST["backbone/templates/tasks/show"]
  
  renderTask: ->
    console.log(this.$('#task-description'))
    @$('#task-title').text(@model.get('name'))
    @$('#task-description').text(@model.get('description'))
  
  render: ->
    $(@el).html(@template())
    @renderTask()
    return this
