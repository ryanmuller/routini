class Shuff.Models.Microtask extends Backbone.Model
  isIncomplete: () ->
    return @get('status') != "complete"


class Shuff.Collections.Microtasks extends Backbone.Collection
  model: Shuff.Models.Microtask
  url: '/microtasks'

  incomplete: () ->
    return @filtered((microtask) ->
      return microtask.isIncomplete()
    )

  filtered: (criteriaFunction) ->
    return new Microtasks(@select(criteriaFunction))

