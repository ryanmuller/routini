class Shuff.Routers.AppRouter extends Backbone.Router
  initialize: (options) ->
    @contexts = new Shuff.Collections.Contexts()
    @contexts.reset options.contexts
    @tasks = new Shuff.Collections.Tasks()
    @tasks.reset options.tasks

    # render context chooser 
    view = new Shuff.Views.ContextsChooser(collection: @contexts)
    $('#context-options').html(view.render().el)

    # render 'all' context if it exists
    @contexts.each((context) ->
      if context.get('name') == 'all'
        context.fetch({
          success: () ->
            view = new Shuff.Views.TasksIndex(collection: context.tasks)
            $('#all-tasks').html(view.renderColumn().el)
        })
    )


  routes:
    "/tasks/:id"    : "showTask",
    "/tasks/none"   : "doNothing"
    "/contexts/:id" : "showContext"
    "/contexts"     : "index"
  
  updateSelectedContext: (id) ->
    $(".context-option").removeClass("selected-context")
    $("#context"+id).addClass("selected-context")

  renderCharts: ->
    $('.log-chart').each(() ->
      ShuffCharts.renderLogs(this)
    )
    $('.value-chart').each(() ->
      ShuffCharts.renderValues(this)
    )
  
  showContext: (id) ->
    $('#task-panel').hide()
    context = @contexts.get(id)
    context.fetch({
      success: () =>
        view = new Shuff.Views.TasksIndex(collection: context.tasks)
        $("#context").html(view.render().el)
        @renderCharts()
        @updateSelectedContext(id)
    })

  showTask: (id) ->
    $('#task-panel').show()
    task = @tasks.get(id)
    task.fetch({
      success: () ->
        view = new Shuff.Views.TasksShow(model: task)
        $('#task').html(view.render().el)
        $('#task-name').text(task.get("name"))
        ShuffClock.reset()
    })

  doNothing: () ->
    view = new Shuff.Views.TasksShow()
    view.doNothing()

  index: () ->
    @contexts.fetch({
      success: () =>
        $("#context").html("")
        $("#task").html("")
        view = new Shuff.Views.ContextsIndex(collection: @contexts)
        $("#context").html(view.render().el)
    })

