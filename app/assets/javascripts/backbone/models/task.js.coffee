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

  lastValue: () ->
    if @logs.length > 0
      @logs.last().get('value')
    else
      ""

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

  valuePoints: (n) ->
    points = []
    @logs.each((log) ->
      if log.has('value') and log.get('value') != ''
        date = log.get('created_at')
        
        # deal with different types of time depending on whether from JSON or
        # created
        # TODO not this
        if date.indexOf('T') == -1
          date = new Date(date)
          date = date.toJSON()

        date = date.split('T')[0]

        points.push([date, log.get('value')])
    )

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
