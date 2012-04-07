class Shuff.Views.TasksEdit extends Backbone.View
  events: {
    "change select" : "changeDisplayType"
  }

  render: () ->
    $item = $('<li>').attr('data-taskid', @model.id)
    $item.append($('<p>').text(@model.get('name')))
    $display_types = $(JST["backbone/templates/tasks/display_types"]())
    if @model.get('display_type') != null
      $display_types.val(@model.get('display_type'))
    $item.append($display_types)
    $(@el).html($item)
    return this

  changeDisplayType: ->
    $select = $('select', @el)
    console.log($select)
    @model.set({
      display_type: $select.val()
    })
    @model.save({},{})

