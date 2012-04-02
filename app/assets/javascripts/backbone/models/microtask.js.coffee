class Shuff.Models.Microtask extends Backbone.Model

class Shuff.Collections.Microtasks extends Backbone.Collection
  model: Shuff.Models.Microtask,
  url: '/microtasks'

