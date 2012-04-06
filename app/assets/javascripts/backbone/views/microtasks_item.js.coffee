class Shuff.Views.MicrotasksItem extends Backbone.View
  template: JST["backbone/templates/microtasks/item"]

  events: {
    "change input": "update"
  }

  render: () ->
    $(@el).html(@template({ microtask: @model }))
    return this

  update: () ->
    status = if @$('input').prop('checked') then "complete" else "incomplete"
    @model.save({ status: status })



