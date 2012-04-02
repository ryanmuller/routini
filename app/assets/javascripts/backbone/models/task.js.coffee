
class Shuff.Models.Task extends Backbone.Model
  urlRoot: '/tasks',

  parseMicrotasks: () ->
    @microtasks = new Shuff.Collections.Microtasks(@get('microtasks'))


class Shuff.Collections.Tasks extends Backbone.Collection
  model: Shuff.Models.Task,
  url: '/tasks'
