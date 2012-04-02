
class Shuff.Models.Task extends Backbone.Model
  urlRoot: '/tasks'

class Shuff.Collections.Tasks extends Backbone.Collection
  model: Shuff.Models.Task
