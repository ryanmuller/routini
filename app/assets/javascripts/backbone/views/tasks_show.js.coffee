class Shuff.Views.TasksShow extends Backbone.View
  initialize: () ->
    _.bindAll(this, "render")
    @model.bind("change", @render)
    @model.microtasks.bind("add", @render)
    @model.microtasks.bind("remove", @render)
    
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

    @model.microtasks.incomplete().each((microtask) ->
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

    microtask = new Shuff.Models.Microtask({ name: @$('input[name=microtask_name]').val() })
    microtask.url = '/tasks/' + @model.get('id') + '/microtasks'
    @model.microtasks.create(microtask)
    @$('input[name=microtask_name]').val('')
    return false

