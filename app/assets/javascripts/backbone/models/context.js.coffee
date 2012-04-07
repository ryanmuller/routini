class Shuff.Models.Context extends Backbone.Model
  initialize: () ->
    @on("change:tasks", @parseTasks)
    @parseTasks()

  urlRoot: '/situations'

  parseTasks: () ->
    @tasks = new Shuff.Collections.Tasks(@get('tasks'))

class Shuff.Collections.Contexts extends Backbone.Collection
  model: Shuff.Models.Context

  url: '/situations'
