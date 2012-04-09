class Shuff.Views.ContextsChooser extends Backbone.View
  initialize: () ->
    _.bindAll(this, "render")
    @collection.bind("change", @render)
    @collection.bind("add",    @render)
    @collection.bind("remove", @render)

  events: {
    'click .context-edit' : 'editContexts'
    'click .context-add'  : 'addContext'
    'click .cancel'             : 'render'
    'click .edit-context-save'  : 'updateContext'
    'submit #create_context'    : 'submitContext'
    'click .context-delete'       : 'deleteContext'
  }

  render: ->
    $el = $(@el)
    $el.html('')
    @collection.each((context) ->
      if context.get('name') != 'all'
        link = $('<a>').text(context.get('name'))
                       .attr('id', 'context'+context.id)
                       .addClass('context-option')
                       .attr('href', '/#/contexts/'+context.id)
                       .attr('data-contextid', context.id)
        $el.append(link)
    )
    $add = $('<a>').addClass('btn2')
                   .addClass('btn-mini')
                   .addClass('context-add')
                   .text('New')
                   .attr('href', '#')
    $edit = $('<a>').addClass('btn2')
                    .addClass('btn-mini')
                    .addClass('context-edit')
                    .text('Edit')
                    .attr('href', '#')
    $el.append($add)
       .append($edit)
    return this



  editContexts: (e) ->
    e.preventDefault()

    $save = $('<a>').attr('href', '#')
                    .addClass('edit-context-save btn btn-mini')
                    .text('Save')
    $cancel = $('<a>').attr('href', '#')
                      .addClass('cancel btn btn-mini')
                      .text('Cancel')

    @$('.context-option').last().after($cancel).after($save)
    @$('.context-add').hide()
    @$('.context-edit').hide()
    $('.context-option').each(() ->
      $this = $(this)
      id = $this.data('contextid')
      $x = $('<a>').attr('href', '#')
                   .append($('<i>').addClass('icon-remove'))
                   .css('margin-right', '8px')
                   .addClass('context-delete')
                   .attr('data-contextid', id)
      $edit = $('<input>').attr('type','text')
                          .val($this.text())
                          .addClass('edit-context-text input-small')
                          .attr('data-contextid', id)

      $this.after($x)
      $this.replaceWith($edit)
    )

    return false

  addContext: (e) ->
    e.preventDefault()

    $form = $('<form>').addClass('form-inline')
                       .css('display', 'inline')
                       .attr('id', 'create_context')
    $text = $('<input>').attr('type', 'text')
                        .attr('placeholder', 'Context name')
                        .addClass('context_name input-medium')
    $save = $('<input>').attr('type', 'submit')
                        .addClass('new-context-save btn btn-mini')
                        .attr('value', 'Save')
    $cancel = $('<a>').attr('href', '#')
                      .addClass('cancel btn btn-mini')
                      .text('Cancel')
    $form.append($text).append($save).append($cancel)
    @$('.context-option').last().after($form)
    @$('.context-add').hide()
    @$('.context-edit').hide()

    return false

  updateContext: (e) ->
    e.preventDefault()
    self = this
    @$('.edit-context-text').each(() ->
      $this = $(this)
      id = $this.data('contextid')
      context = self.collection.get(id)
      context.save({ name: $this.val() },
                   { success: -> self.render() })
    )
    return false

  deleteContext: (e) ->
    e.preventDefault()

    self = this
    id = $(e.currentTarget).data('contextid')
    context = self.collection.get(id)
    if confirm("Are you sure you want to delete this context?")
      context.destroy({ success: (model, response) -> self.render() })

    return false


  submitContext: (e) ->
    e.preventDefault()

    context = new Shuff.Models.Context({ name: @$('input.context_name').val() })
    @collection.create(context)
    @render()
    return false




