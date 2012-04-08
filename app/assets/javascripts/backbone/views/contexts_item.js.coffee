class Shuff.Views.ContextsItem extends Backbone.View
  initialize: () ->
    _.bindAll(this, "render")
    @model.tasks.bind("change", @render)
    @model.tasks.bind("add",    @render)
    @model.tasks.bind("remove", @render)

  template: JST["backbone/templates/contexts/item"]

  events: {
    "submit .new_task": "submit"
  }

  renderTasks: () ->
    $context_tasks = @$('.context-tasks')
    @model.tasks.each((task) ->
      view = new Shuff.Views.TasksEdit({ model: task })
      $context_tasks.append(view.render().el)
    )

  render: () ->
    $(@el).html(@template({ context: @model }))
    @renderTasks()
    return this

  submit: (e) ->
    e.preventDefault()
    
    task = new Shuff.Models.Task({
      name:         @$('input[name=name]').val()
      display_type: @$('select[name=display_type]').val()
      time:         @$('input[name=time]').val()
    })
    task.url = '/situations/'+@model.get('id')+'/tasks'
    @model.tasks.create(task, { wait: true })
    return false




