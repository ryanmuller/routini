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
    new Shuff.Routers.AppRouter({tasks: tasks, contexts: contexts})
    Backbone.history.start()


