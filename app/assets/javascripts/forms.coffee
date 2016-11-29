$document.on "focusin focusout", ".input", (e)->
  $input_wrap = $(this)
  

  if e.type == 'focusin'
    $input_wrap.addClass("focus")
  else if e.type == 'focusout'
    $input_wrap.removeClass('focus')

$document.on "keyup", ".input.string, .input.text, .input.phone", (e)->

  $input_wrap = $(this)
  $target_input = $(e.target)
  val = $target_input.val()
  console.log val
  if val.length > 0
    $input_wrap.changeClasses("not-empty", "empty") # $input_wrap.changeClasses("not-empty", "empty") #

  else
    $input_wrap.changeClasses("empty", "not-empty") # $input_wrap.removeClass("not-empty").addClass("empty")

  $(this).trigger("after_keyup", e)


$document.on "click", ".input label:not([for])", ()->
  $(this).parent().children().filter("input").first().trigger("focus")

set_valid_value = ()->

  $input = $(this)
  step = parseInt($input.attr("step"))
  val = parseInt($input.val())
  min = parseInt($input.attr("min")) || 0
  max = parseInt($input.attr("max"))

  normalized_value = val

  if step > 1

    valid = Math.ceil(val / step ) == val / step
    if !valid
      normalized_value = Math.ceil(val / step) * step


  if normalized_value < min
    normalized_value = min
  else if normalized_value > max
    normalized_value = max

  if Number.isNaN(normalized_value)
    normalized_value = min


  console.log "normalized_value: ", normalized_value

  $input.val(normalized_value.toString())


$document.on "keyup", "input[type=number][step]", (e)->
  self = this
  e.stopImmediatePropagation()

  delay("keyup",
    ()->
      set_valid_value.apply(self)
      $(self).trigger("after_keyup", e)
    1000
  )




$document.on "ready page:load", ()->
  $("select").each ()->
    #init_selectize.call(this)
    $(this).niceSelect()