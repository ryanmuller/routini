class Shuff.Routers.TasksRouter extends Backbone.Router
  initialize: (options) ->
    @tasks = new Shuff.Collections.Tasks()
    @tasks.reset options.tasks

  routes:
    "/tasks/:id" : "show"

  show: (id) ->
    task = @tasks.get(id)
    task.fetch({
      success: () ->
        view = new Shuff.Views.Tasks.ShowView(model: task)
        $('#task').html(view.render().el)
        $('#task-name').text(task.get("name"))
        ShuffClock.reset()
    })


