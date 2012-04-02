class Shuff.Routers.ContextsRouter extends Backbone.Router
  initialize: (options) ->


  routes:
    "/contexts/:id": "show"
  
  show: (id) ->
    alert("hi there")
    #@view = new Routini.Views.Tasks.IndexView()
    #$("#context").html(@view.render().el)

