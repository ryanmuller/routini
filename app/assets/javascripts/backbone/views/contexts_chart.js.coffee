class Shuff.Views.ContextsChart extends Backbone.View
  initialize: (options) ->
    _.bindAll(this, "render", "renderUpdate")
    @collection.bind("change", @renderUpdate)
    @collection.bind("add",    @renderUpdate)
    @collection.bind("remove", @renderUpdate)
    options.evt.bind("finishTask", @renderUpdate)


  template: JST['backbone/templates/contexts/chart']

  renderChart: ->
    data = []
    @collection.each((context) ->
      # TODO move logic to model
      points = [0,0,0,0,0,0,0]
      context.tasks.each((task) ->
        logPts = task.logPoints(7)

        for i in [0,1,2,3,4,5,6]
          points[i] += logPts[i]
      )
      data.push({ name: context.escape('name'), data: points })
    )

    ShuffCharts.renderDaily($('#daily-chart'), data)

  render: ->
    $(@el).html(@template())
    return this

  renderUpdate: ->
    @render()
    @renderChart()

  submit: (e) ->
    e.preventDefault()

    $input = @$('input#context_name')
    context = new Shuff.Models.Context({ name: $input.val() })
    $input.val('')
    @collection.create(context, { wait: true })

    return false

