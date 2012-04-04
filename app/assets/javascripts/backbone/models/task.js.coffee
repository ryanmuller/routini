
class Shuff.Models.Task extends Backbone.Model
  urlRoot: '/tasks',

  parseMicrotasks: () ->
    @microtasks = new Shuff.Collections.Microtasks(@get('microtasks'))
  ,

  isInContext: (contextId) ->
    return @get('context_ids').indexOf(contextId) != -1
   


class Shuff.Collections.Tasks extends Backbone.Collection
  model: Shuff.Models.Task,
  url: '/tasks'

  inContext: (contextId) ->
    return @filtered((task) ->
      return task.isInContext(contextId)
    )
  ,

  filtered: (criteriaFunction) ->
    return new Tasks(@select(criteriaFunction))
