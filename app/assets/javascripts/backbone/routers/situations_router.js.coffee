class Routini.Routers.SituationsRouter extends Backbone.Router
  initialize: (options) ->


  routes:
    "/contexts/:id": "show"
  
  show: (id) ->
    context = new Situation({ id: id })
    @view = new Routini.Views.Situations.ShowView()
    $("#context").html(@view.render().el)

