window.css_vendors = (properties)->
  props = {}
  props_need_vendors = ["transform", "transition", "animation"]
  vendors = ["-webkit-", "-moz-", "-ms-", "-o-"]
  for k, v of properties
    if props_need_vendors.indexOf(k) >= 0
      for vendor in vendors
        props["#{vendor}#{k}"] = v

    props[k] = v

  props
