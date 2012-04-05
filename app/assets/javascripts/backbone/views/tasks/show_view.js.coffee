Shuff.Views.Tasks ||= {}

class Shuff.Views.Tasks.ShowView extends Backbone.View
  template: JST["backbone/templates/tasks/show"]

  events: {
    "submit": "finish"
  }
  
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

  renderNoTask: ->
    $('#task-name').text("Doing nothing!")
    $('#task').html("")

  finish: (e) ->
    e.preventDefault()
    
    logUrl = '/tasks/' + @model.get('id') + '/logs.json'
    logData = { log: { value: $('#log-value').val() }}
    console.log(logUrl, logData)
    $.post(logUrl, logData, @renderNoTask)

    return false


