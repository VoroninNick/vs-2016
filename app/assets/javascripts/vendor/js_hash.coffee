window.keys = (hash)->
  keys = []
  for k, v of hash
    keys.push(k)

  keys

window.has_keys = (hash)->
  keys(hash).length > 0


window.value_props = (obj) ->
  obj2 = {}
  for k of obj
    if typeof obj[k] != 'function'
      obj2[k] = obj[k]
  obj2

window.value_prop_keys = (obj, name_not_prefix) ->
  arr = []
  if name_not_prefix and !name_not_prefix.length
    name_not_prefix = null
  for k of obj
    if typeof obj[k] != 'function' and (!name_not_prefix or !k.startsWith(name_not_prefix))
      arr.push k
  arr.sort()
