class Shuff.Views.ContextsIndex extends Backbone.View
  initialize: (options) ->
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

    $input = @$('input#context_name')
    context = new Shuff.Models.Context({ name: $input.val() })
    $input.val('')
    @collection.create(context, { wait: true })

    return false

