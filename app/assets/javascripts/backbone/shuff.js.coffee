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
    new Shuff.Routers.TasksRouter({tasks: tasks})
    new Shuff.Routers.ContextsRouter()
    Backbone.history.start()



