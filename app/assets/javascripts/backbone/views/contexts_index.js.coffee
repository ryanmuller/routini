class Shuff.Views.ContextsIndex extends Backbone.View
  template: JST["backbone/templates/contexts/index"]

  events: {
    "submit #new_context": "submit"
  }

  renderContexts: ->
    $contexts = @$('#contexts')
    $contexts.html('')
    @collection.each((context) ->
      view = new Shuff.Views.ContextsItem({ model: context })
      $contexts.append(view.render().el)
    )

  render: ->
    $(@el).html(@template({ contexts: @collection }))
    @renderContexts()
    return this

  submit: (e) ->
    e.preventDefault()

    context = new Shuff.Models.Context()
    context.set({
      name: @$('input#context_name').val()
    })
    context.save({}, {
      success: (model, response) =>
        @$('input#context_name').val('')
        view = new Shuff.Views.ContextsItem({ model: model })
        @$('#contexts').append(view.render().el)
    })
    return false


