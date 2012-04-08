class Shuff.Views.TasksIndex extends Backbone.View
  template: JST["backbone/templates/tasks/index"]

  renderBinaryDisplay: (task, el) ->
    el.append('<div class="bigcheck">x</div>')

  renderTodoDisplay: (task, el) ->
    $ul = $('<ul>')

    for k,item of task.get('dones')
      $ul.append($('<li>').text(item)
                          .css('text-decoration', 'line-through'))

    for k,item of task.get('todos')
      $ul.append($('<li>').text(item))

    el.append($ul)

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

    name = $('<a>').attr('href', '/#/tasks/' + task.escape('id'))
                   .addClass('dash-task')
                   .append($('<h3>').text(task.escape('name')))

    $task.append(name)

    switch task.get("display_type")
      when "binary"     then binary(task, $task)
      when "todo"       then todo(task, $task)
      when "values"     then values(task, $task)
      when "last_value" then last_value(task, $task)
      else                   logs(task, $task)


  renderColumn: ->
    renderTask = @renderTask
    self = this

    @collection.each((task) ->
      $task = $('<div>')
      self.renderTask(task, $task, self)
      $(self.el).append($task)
    )
    return this

  render: ->
    $el = $(@el)
    $row = $('<div>').addClass('row')

    self = this

    @collection.each((task, index) ->
      if index != 0 and index % 3 == 0
        # a set of three has been added, start new row
        $el.append($row)
        $row = $('<div>').addClass('row')

      $task = $('<div>').addClass('span3')

      self.renderTask(task, $task, self)

      $row.append($task)
    )

    # add last row
    $el.append($row)

    #$(@el).html(@template({ tasks: @collection }))
    return this
