class Shuff.Views.ContextsChooser extends Backbone.View
  initialize: () ->
    _.bindAll(this, "render")
    @collection.bind("change", @render)
    @collection.bind("add",    @render)
    @collection.bind("remove", @render)

  render: ->
    $el = $(@el)
    $el.html('')
    @collection.each((context) ->
      if context.get('name') != 'all'
        link = $('<a>').text(context.get('name'))
                       .attr('id', 'context'+context.id)
                       .addClass('context-option')
                       .attr('href', '/#/contexts/'+context.id)
        $el.append(link)
    )
    return this
