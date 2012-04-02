class Routini.Models.Situation extends Backbone.Model
  urlRoot: 'situation'

class Routini.Collections.SituationsCollection extends Backbone.Collection
  model: Routini.Models.Situation
  url: '/situations'
