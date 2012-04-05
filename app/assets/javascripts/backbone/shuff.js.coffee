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
  init: (tasks, contexts) ->
    new Shuff.Routers.TasksRouter({tasks: tasks})
    new Shuff.Routers.ContextsRouter({contexts: contexts, tasks: tasks})
    Backbone.history.start()


