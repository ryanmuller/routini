class Shuff.Routers.AppRouter extends Backbone.Router
  initialize: (options) ->
    @contexts = new Shuff.Collections.Contexts()
    @contexts.reset options.contexts
    @tasks = new Shuff.Collections.Tasks()
    @tasks.reset options.tasks

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
    tasks = @tasks.inContext(parseInt(id))
    view = new Shuff.Views.TasksIndex(collection: tasks)
    $("#context").html(view.render().el)
    @renderCharts()
    @updateSelectedContext(id)

  showTask: (id) ->
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

