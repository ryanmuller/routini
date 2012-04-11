class Shuff.Views.ContextsShow extends Backbone.View
  template: JST["backbone/templates/contexts/show"]
  
  events: {
    'click .new-task-btn'   : 'renderNewTask'
    'click .edit_task_save' : 'submitTask'
    'click .cancel'         : 'preventAndRender'
  }

  preventAndRender: (e) ->
    e.preventDefault()
    @render()
    return false

  renderBinaryDisplay: (task, el) ->
    el.append('<div class="bigcheck">x</div>')

  renderTodoDisplay: (task, el) ->
    $ul = $('<ul>')

    for k,item of task.get('dones')
      $ul.append($('<li>').html(ShuffUtils.replaceURLs(item))
                          .css('text-decoration', 'line-through'))

    for k,item of task.get('todos')
      $ul.append($('<li>').html(ShuffUtils.replaceURLs(item)))

    el.append($ul)

  renderRandomDisplay: (task, el) ->
    if task.get('todos') != null
      n = task.get('todos').length
      if n > 0
        choice = Math.floor(Math.random() * n)
        el.append($('<p>').html(ShuffUtils.replaceURLs(task.get('todos')[choice])))

  renderValuesDisplay: (task, el) ->
    if task.has('value_pts') and task.get('value_pts').length > 0
      chart = $('<div>').addClass('value-chart')
                        .attr('id', 'task' + task.get('id') + 'chart')
                        .css('width','210px')
                        .css('height','150px')
                        .attr('data-pts', JSON.stringify(task.get('value_pts')))
      el.append(chart)

      last_val = task.get('value_pts')[task.get('value_pts').length-1].toString().split(',')[1]
      el.append($('<p>').text('Last value: ' + last_val))
    else
      el.append($('<p>').text('No values logged.'))

  renderLastValueDisplay: (task,el) ->
    if task.has('value_pts') and task.get('value_pts').length > 0
      last_val = task.get('value_pts')[task.get('value_pts').length-1].toString().split(',')[1]
      el.append($('<p>').text(last_val))

  renderLogsDisplay: (task, el) ->
    if task.has('log_pts') and task.get('log_pts').length > 0
      chart = $('<div>').addClass('log-chart')
                        .attr('id', 'task' + task.get('id') + 'chart')
                        .css('width','210px')
                        .css('height','150px')
                        .attr('data-pts', JSON.stringify(task.get('log_pts')))
      el.append(chart)

      last_val = task.get('log_pts')[task.get('log_pts').length-1]
      el.append($('<p>').text('Completed today: ' + last_val))
    else
      el.append($('<p>').text('None completed.'))

  renderTask: (task, $task, self) ->
    binary = self.renderBinaryDisplay
    logs = self.renderLogsDisplay
    todo = self.renderTodoDisplay
    values = self.renderValuesDisplay
    last_value = self.renderLastValueDisplay
    random = self.renderRandomDisplay

    name = $('<a>').attr('href', '/#/contexts/' + @model.id + '/tasks/' + task.id)
                   .addClass('dash-task')
                   .append($('<h3>').text(task.escape('name')))

    $task.append(name)

    switch task.get("display_type")
      when "binary"     then binary(task, $task)
      when "todo"       then todo(task, $task)
      when "values"     then values(task, $task)
      when "last_value" then last_value(task, $task)
      when "random"     then random(task, $task)
      else                   logs(task, $task)


  renderColumn: ->
    renderTask = @renderTask
    self = this

    @model.tasks.each((task) ->
      $task = $('<div>')
      self.renderTask(task, $task, self)
      $(self.el).append($task)
    )
    return this

  renderNewTask: ->
    @$('.new-task-area').html(JST['backbone/templates/tasks/form']())


  render: ->
    $el = $(@el)
    $el.html('')
    $row = $('<div>').addClass('row')

    self = this

    @model.tasks.each((task, index) ->
      if index != 0 and index % 3 == 0
        # a set of three has been added, start new row
        $el.append($row)
        $row = $('<div>').addClass('row')

      $task = $('<div>').addClass('span3')

      self.renderTask(task, $task, self)

      $row.append($task)
    )

    # one more for a new task...
    if $row.children().length == 3
      $el.append($row)
      $row = $('<div>').addClass('row')

    #$newtask = $(JST["backbone/templates/tasks/form"]())

    $newtaskbtn = $('<a>').addClass('btn new-task-btn').text('New task')
    $newtask = $('<div>').addClass('span3 new-task-area').append($newtaskbtn)

    $row.append($newtask)

    # add last row
    $el.append($row)

    #$(@el).html(@template({ tasks: @collection }))
    return this

  submitTask: (e) ->
    e.preventDefault()

    task = new Shuff.Models.Task({ name: @$('input[name=name]').val(), description: @$('input[name=description]').val(), time: @$('input[name=time]').val(), display_type: @$('select[name=display_type]').val() })
    task.url = '/situations/' + @model.id + '/tasks/'
    @model.tasks.create(task, { wait: true })
    @render()

    return false
