class Shuff.Routers.AppRouter extends Backbone.Router
  initialize: (options) ->
    @contexts = new Shuff.Collections.Contexts()
    @contexts.reset options.contexts

    # event aggregator http://lostechies.com/derickbailey/2011/07/19/references-routing-and-the-event-aggregator-coordinating-views-in-backbone-js/
    @evt = _.extend({}, Backbone.Events)
    evt = @evt

    # render context chooser 
    view = new Shuff.Views.ContextsChooser(collection: @contexts)
    $('#context-chooser').html(view.render().el)

    # render main chart
    view = new Shuff.Views.ContextsChart(collection: @contexts, evt: evt)
    $('#info-panel').prepend(view.render().el)
    view.renderChart()
    

    # render 'all' context if it exists
    @contexts.each((context) ->
      if context.get('name') == 'all'
        view = new Shuff.Views.ContextsShow({ model: context, evt: evt })
        $('#all-tasks').html(view.render().el)
    )


  routes:
    "/contexts/:cid/tasks/:tid" : "showTask",
    "/contexts/:id"             : "showContext"
  
  updateSelectedContext: (id) ->
    $(".context-option").removeClass("selected-context")
    $("#context"+id).addClass("selected-context")

  showContext: (id) ->
    $('#task-panel').hide()
    context = @contexts.get(id)
    evt = @evt
    view = new Shuff.Views.ContextsShow({ model: context, evt: evt })
    $("#context").html(view.render().el)
    view.renderCharts()
    @updateSelectedContext(id)

  showTask: (cid, tid) ->
    $('#task-panel').show()
    context = @contexts.get(cid)
    task = context.tasks.get(tid)
    view = new Shuff.Views.TasksShow({ model: task, evt: @evt })
    $('#task-panel').html(view.render().el)
    ShuffClock.renderTimer(task.get('time'))
