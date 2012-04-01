class Routini.Models.Situation extends Backbone.Model
  paramRoot: 'situation'

  defaults:

class Routini.Collections.SituationsCollection extends Backbone.Collection
  model: Routini.Models.Situation
  url: '/situations'
