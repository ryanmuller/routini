class Shuff.Views.TasksShow extends Backbone.View
  initialize: () ->
    #@model.on("change", @render)
    
  template: JST["backbone/templates/tasks/show"]

  events: {
    "submit #task-finish-form": "finish",
    "submit #create_microtask": "submit"
  }
  
  renderTask: ->
    @$('#task-description').html(ShuffUtils.replaceURLs(@model.get('description')))

  renderMicrotasks: ->
    return unless @model.incompleteMicrotasks
    $microtasks = @$('#microtasks')
    $microtasks.html('')
    @model.incompleteMicrotasks.each((microtask) ->
      view = new Shuff.Views.MicrotasksItem({ model: microtask })
      $microtasks.append(view.render().el)
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
    $.post(logUrl, logData, @renderNoTask)

    return false

  submit: (e) ->
    e.preventDefault()

    microtask = new Shuff.Models.Microtask()
    microtask.url = '/tasks/' + @model.get('id') + '/microtasks'
    microtask.set({ name: @$('input[name=microtask_name]').val() })
    microtask.save({}, {
      success: (model, response) =>
        @$('input[name=microtask_name]').val("")
        # hack because I can't figure out how to bind renderMicrotasks
        # correctly
        $microtasks = @$('#microtasks')
        view = new Shuff.Views.MicrotasksItem({ model: model })
        $microtasks.append(view.render().el)
    })
    return false

