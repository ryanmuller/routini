Shuff.Views.Tasks ||= {}

class Shuff.Views.Tasks.ShowView extends Backbone.View
  template: JST["backbone/templates/tasks/show"]
  
  renderTask: ->
    @$('#task-description').text(@model.get('description'))

  renderMicrotasks: ->
    return unless @model.incompleteMicrotasks
    $microtasks = @$('#microtasks')
    $microtasks.html('')
    @model.incompleteMicrotasks.each((microtask) ->
      microtaskView = $('<form><input type="checkbox" class="action-cb"> <span class="action-name"></span></form>')
      $('.action-name', microtaskView).text(microtask.get('name'))
      $microtasks.append(microtaskView)
    )
  
  render: ->
    $(@el).html(@template())
    @renderTask()
    @renderMicrotasks()
    return this
