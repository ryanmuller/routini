class Shuff.Routers.ContextsRouter extends Backbone.Router
  initialize: (options) ->
    @contexts = new Shuff.Collections.Contexts()
    @contexts.reset options.contexts
    @tasks = new Shuff.Collections.Tasks()
    @tasks.reset options.tasks


  routes:
    "/contexts/:id": "show"
  
  show: (id) ->
    tasks = @tasks.inContext(parseInt(id))
    view = new Shuff.Views.Tasks.IndexView(collection: tasks)
    $("#context").html(view.render().el)

