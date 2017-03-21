window.rand = (min, max, interval) ->
  if typeof interval == 'undefined'
    interval = 1
  r = Math.floor(Math.random() * (max - min + interval) / interval)
  r * interval + min