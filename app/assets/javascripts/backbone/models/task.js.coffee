class Shuff.Models.Task extends Backbone.Model
  initialize: () ->
    @on("change:microtasks", @parseMicrotasks)
    @parseMicrotasks

  urlRoot: '/tasks'

  parseMicrotasks: () ->
    @microtasks = new Shuff.Collections.Microtasks(@get('microtasks'))
    @microtasks.url = '/tasks/' + @get('id') + '/microtasks'
    @incompleteMicrotasks = if @microtasks then @microtasks.incomplete() else []

  isInContext: (contextId) ->
    return @get('context_ids').indexOf(contextId) != -1



class Shuff.Collections.Tasks extends Backbone.Collection
  model: Shuff.Models.Task

  url: '/tasks'

  inContext: (contextId) ->
    return @filtered((task) ->
      return task.isInContext(contextId)
    )

  filtered: (criteriaFunction) ->
    return new Tasks(@select(criteriaFunction))
