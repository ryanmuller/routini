class Shuff.Views.TasksShow extends Backbone.View
  initialize: () ->
    _.bindAll(this, "render")
    @model.bind("change", @render)
    @model.microtasks.bind("add", @render)
    @model.microtasks.bind("remove", @render)
    
  template: JST["backbone/templates/tasks/show"]

  events: {
    "submit #task-finish-form" : "finish",
    "submit #create_microtask" : "submit"
    "click .edit"              : "editTask"
    "click .delete"            : "deleteTask"
    "click .edit_task_save"    : "updateTask"
    'click .cancel'            : 'renderAndClock'
  }
  
  renderTask: ->
    @$('#task-name').text(@model.get('name'))
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

  renderAndClock: ->
    @render()
    ShuffClock.renderTimer(@model.get('time'))

  renderNoTask: ->
    $('#task-panel').html("")

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

  updateTask: (e) ->
    e.preventDefault()

    $el = $(@el)

    @model.save({ name: $el.find('input[name=name]').val(), description: $el.find('input[name=description]').val(), time: $el.find('input[name=time]').val(), display_type: $el.find('select[name=display_type]').val() }, { success: => @renderAndClock() })
    return false

  editTask: (e) ->
    e.preventDefault()

    $form = $(JST["backbone/templates/tasks/form"]())
    $form.find('input[name=name]').val(@model.get('name'))
    $form.find('input[name=description]').val(@model.get('description'))
    $form.find('select[name=display_type]').val(@model.get('display_type'))
    $form.find('input[name=time]').val(@model.get('time'))

    @$('#task-info').html('')
                    .html($form)

    
    #@$('#microtasks div').each(() ->
    #  $this = $(this)
    #  #id = $this.data('microtaskid')
    #  id = 0
    #  $x = $('<a>').attr('href', '#')
    #               .append($('<i>').addClass('icon-remove'))
    #               .css('margin-right', '8px')
    #               .addClass('context-delete')
    #               .attr('data-contextid', id)
    #               .after('<br>')
    #  $edit = $('<input>').attr('type','text')
    #                      .val($this.text())
    #                      .addClass('edit-context-text input')
    #                      .attr('data-contextid', id)
    #  $this.after($x)
    #  $this.replaceWith($edit)
    #)


    return false

  deleteTask: (e) ->
    $el = $(@el)
    e.preventDefault()
    if confirm("Are you sure you want to delete this task?")
      @model.destroy({ success: (model, response) ->
        $('#task-panel').hide()
      })

    return false


