class Routini.Routers.TasksRouter extends Backbone.Router

  routes:
    "": "index"
  
  index: () ->
    @view = new Routini.Views.Situations.ShowView()
    $("#context").html(@view.render().el)
