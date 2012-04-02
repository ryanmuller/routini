class Shuff.Routers.TasksRouter extends Backbone.Router

  routes:
    "/tasks/:id" : "show"
  
  show: (id) ->
    alert("task "+id)
    view = new Shuff.Views.Tasks.ShowView()
    $('#task').html(view.render().el)

