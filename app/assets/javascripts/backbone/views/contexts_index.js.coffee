class Shuff.Views.ContextsIndex extends Backbone.View
  initialize: () ->
    _.bindAll(this, "render")
    @collection.bind("change", @render)
    @collection.bind("add",    @render)
    @collection.bind("remove", @render)

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

    @$('input#context_name').val('')
    context = new Shuff.Models.Context({ name: @$('input#context_name').val() })
    @collection.create(context, { wait: true })

    return false

