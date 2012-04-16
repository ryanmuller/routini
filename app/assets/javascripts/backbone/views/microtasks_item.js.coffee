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
    @$('.action-name').css('text-decoration', 'line-through')
    @model.save({ status: status })



