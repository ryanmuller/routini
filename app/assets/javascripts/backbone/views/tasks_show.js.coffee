class Shuff.Views.TasksShow extends Backbone.View
  initialize: (options) ->
    _.bindAll(this, "render", "renderMicrotasks")
    @model.microtasks.bind("add", @renderMicrotasks)
    @model.microtasks.bind("remove", @renderMicrotasks)
    @evt = options.evt
    
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
    @$('#task-description').html('')
    if @model.has('description')
      @$('#task-description').html(ShuffUtils.replaceURLs(@model.get('description'), 80))
    
  renderMicrotasks: ->
    $microtasks = @$('#microtasks')
    $microtasks.html('')

    evt = @evt
    @model.microtasks.incomplete().each((microtask) ->
      view = new Shuff.Views.MicrotasksItem({ model: microtask, evt: evt })
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
    
    log = new Shuff.Models.Log({ value: @$('#log-value').val() })
    log.url = '/tasks/' + @model.get('id') + '/logs.json'
    params =
      wait: true
      success: (model, response) =>
        @evt.trigger("finishTask")
        # TODO better way to do this?
        window.location.replace(window.location.hash.split('/').slice(0,3).join('/'))

    @model.logs.create(log, params)

    return false

  submit: (e) ->
    e.preventDefault()

    microtask = new Shuff.Models.Microtask({ name: @$('input[name=microtask_name]').val() })
    microtask.url = '/tasks/' + @model.get('id') + '/microtasks'
    params =
      wait: true
      success: (model, response) =>
        @evt.trigger('changeMicrotasks')

    @model.microtasks.create(microtask, params)
    @$('input[name=microtask_name]').val('')
    return false

  updateTask: (e) ->
    e.preventDefault()

    $el = $(@el)

    task_params =
      name:         $el.find('input[name=name]').val()
      description:  $el.find('input[name=description]').val()
      time:         $el.find('input[name=time]').val()
      display_type: $el.find('select[name=display_type]').val()

    other_params =
      success: () => @renderAndClock()
      wait:    true

    @model.save(task_params, other_params)
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
    e.preventDefault()

    params =
      success: (model, response) -> $('#task-panel').hide()
      wait:    true

    if confirm("Are you sure you want to delete this task?")
      @model.destroy(params)

    return false


