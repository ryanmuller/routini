class Shuff.Views.MicrotasksItem extends Backbone.View
  initialize: (options) ->
    @evt = options.evt

  template: JST["backbone/templates/microtasks/item"]

  events: {
    "change input": "update"
  }

  render: () ->
    $(@el).html(@template({ microtask: @model }))
    return this

  update: () ->
    if @$('input').prop('checked') 
      status = "complete"
      @$('.action-name').css('text-decoration', 'line-through')
    else
      status = "incomplete"
      @$('.action-name').css('text-decoration', 'none')

    modelParams =
      status: status

    params =
      success: (model, response) =>
        @evt.trigger('changeMicrotasks')

    @model.save(modelParams, params)
