class Shuff.Views.TasksShow extends Backbone.View
  initialize: () ->
    _.bindAll(this, "render")
    @model.bind("change", @render)
    @model.microtasks.bind("add", @render)
    @model.microtasks.bind("remove", @render)
    
  template: JST["backbone/templates/tasks/show"]

  events: {
    "submit #task-finish-form"        : "finish",
    "submit #create_microtask"        : "submit"
    "click .edit"                     : "editTask"
    "click .delete"                   : "deleteTask"
    "focusout .edit_task_description" : "updateTask"
    "change select"                   : "updateTask"
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

  updateTask: () ->
    @model.save({ description:  $('.edit_task_description').val(), display_type: $('select').val() },
                { success: => @render() })

  editTask: (e) ->
    e.preventDefault()

    $('.edit').hide()
      
    $description = $('<input>').addClass('edit_task_description')
                                  .val(@model.get('description'))

    $display_type = $(JST["backbone/templates/tasks/display_types"]())
    if @model.get('display_type') != null
      $display_type.val(@model.get('display_type'))

    @$('#task-description').html('')
                           .append($description)
                           .append($display_type)

    return false

  deleteTask: (e) ->
    $el = $(@el)
    e.preventDefault()
    if confirm("Are you sure you want to delete this task?")
      @model.destroy({ success: (model, response) ->
        $('#task-panel').hide()
      })

    return false



