class Shuff.Views.ContextsItem extends Backbone.View
  template: JST["backbone/templates/contexts/item"]

  events: {
    "submit .new_task": "submit"
  }

  renderTasks: () ->
    $context_tasks = @$('.context-tasks')
    @model.tasks.each((task) ->
      $item = $('<li>')
      $item.append($('<p>').text(task.get('name')))
      $context_tasks.append($item)
    )

  render: () ->
    $(@el).html(@template({ context: @model }))
    @renderTasks()
    return this

  submit: (e) ->
    e.preventDefault()
    
    task = new Shuff.Models.Task()
    task.set({
      name:         @$('input[name=name]').val()
      display_type: @$('select[name=display_type]').val()
      time:         @$('input[name=time]').val()
    })
    task.url = '/situations/'+@model.get('id')+'/tasks'
    task.save({}, {
      success: (model, response) =>
        console.log(model)
        @$('input[name=name]').val('')
        @$('input[name=time]').val('')
        @$('.context-tasks').append('<li>'+model.get('name')+'</li>')
    })
    return false




