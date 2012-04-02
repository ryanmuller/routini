#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Shuff =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: (tasks) ->
    new Shuff.Routers.TasksRouter()
    new Shuff.Routers.ContextsRouter()
    @tasks = new Shuff.Collections.Tasks(tasks)
    Backbone.history.start()



