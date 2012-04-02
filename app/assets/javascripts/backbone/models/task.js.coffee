
class Shuff.Models.Task extends Backbone.Model
  urlRoot: '/tasks',

  parseMicrotasks: () ->
    @microtasks = new Shuff.Collections.Microtasks(@get('microtasks'))
   
  inContext: (contextId) ->
    return @filtered((task) ->
      return task.context_id == contextId
    # actually should be "contextId is among task.context_ids"

  filtered: (criteriaFunction) ->
    return new Tasks(@select(criteriaFunction))


class Shuff.Collections.Tasks extends Backbone.Collection
  model: Shuff.Models.Task,
  url: '/tasks'
