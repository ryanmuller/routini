
class Routini.Models.Task extends Backbone.Model
  urlRoot: '/tasks'

class Routini.Collections.SituationsCollection extends Backbone.Collection
  model: Routini.Models.Task
