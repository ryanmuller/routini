class Shuff.Models.Task extends Backbone.Model
  initialize: () ->
    @on("change:microtasks", @parseMicrotasks)
    @parseMicrotasks()
    @on("change:logs", @parseLogs)
    @parseLogs()

  urlRoot: '/tasks'

  parseMicrotasks: () ->
    @microtasks = new Shuff.Collections.Microtasks(@get('microtasks'))
    @microtasks.url = '/tasks/' + @get('id') + '/microtasks'
    @incompleteMicrotasks = if @microtasks then @microtasks.incomplete() else []

  parseLogs: () ->
    @logs = new Shuff.Collections.Logs(@get('logs'))
    @logs.url = '/tasks/' + @get('id') + '/logs'

  isInContext: (contextId) ->
    return @get('context_ids').indexOf(contextId) != -1

  logPoints: (days) ->
    now = Date.now()
    dday = 86400000

    day = Date.now() - days*dday

    points = []
    @logs.each((log) ->
      created = Date.parse(log.get('created_at'))

      while day < created
        points.push(0)
        day = day + dday

      points[points.length-1] += 1
    )

    while day < now
      points.push(0)
      day = day + dday

    return points


class Shuff.Collections.Tasks extends Backbone.Collection
  model: Shuff.Models.Task

  url: '/tasks'

  inContext: (contextId) ->
    return @filtered((task) ->
      return task.isInContext(contextId)
    )

  filtered: (criteriaFunction) ->
    return new Tasks(@select(criteriaFunction))
