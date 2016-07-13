jquery_functions = {}
jquery_functions.val = $.fn.val



$.fn.val = ()->
  if $(this).filter(".input").length
    $input_wrap = $(this)
    if $input_wrap.filter(".string").length
      $input = $input_wrap.find("input")
      return jquery_functions.val.apply($input, arguments)
    else if $input_wrap.filter(".text").length
      $textarea = $input_wrap.find("textarea")
      return jquery_functions.val.apply($textarea, arguments)
  else
    return jquery_functions.val.apply(this, arguments)

$.fn.hasAttribute = (name)->
  return $(this).attr(name) != undefined

$("body").on "focus", ".input", (event)->
  $input_wrap = $(this)
  $input_wrap.addClass("focus")

$("body").on "focusout", ".input", (event)->
  $input_wrap = $(this)
  $input_wrap.removeClass("focus")
  $input_wrap.validate()
  #$form = $input_wrap.closest("form")
  #$form.validate()


handle_keyup = ()->
  $input_wrap = $(this)
  #$form = $input_wrap.closest("form")

  value = $input_wrap.val()
  revalidate = false
  if (value.length && $input_wrap.hasClass("empty")) || ( !value.length && $input_wrap.hasClass("not-empty") ) || !$input_wrap.hasClass("empty") && $input_wrap.hasClass("not-empty")
    revalidate = true

  if value.length
    $input_wrap.addClass("not-empty").removeClass("empty")
  else
    $input_wrap.addClass("empty").removeClass("not-empty")

  $input_wrap.validate()

$("body").on "keyup", ".input", handle_keyup



$.fn.validate = ()->
  $target = $(this)
  tag_name = $target.get(0).tagName.toLowerCase()
  if tag_name == 'form'
    $form = $target
    res = $form.find(".input").map (()->
      return $(this).validate()
    )
    $form.addClass("tried-to-send")
    valid = true
    for r in res
      if !r
        valid = false
        break
    return valid
  else
    if $target.hasClass("input")
      $input_wrap = $target
      value = $input_wrap.val()
      required = $input_wrap.hasAttribute("required")
      valid = true
      if required
        if !value.length
          $input_wrap.addClass("invalid-required")
          valid = false
          $required_message = $input_wrap.find(".error.required")
          if !$required_message.length
            input_id = $input_wrap.find(".input-label").attr("for")
            label = $input_wrap.find(".input-label").text()
            required_message = $input_wrap.attr("required-message") || "#{label} is required"
            $input_wrap.append("<label class='error required' for='#{input_id}'>#{required_message}</label>")
        else
          $input_wrap.removeClass("invalid-required")
          $input_wrap.find(".error.required").remove()


      if valid
        $input_wrap.removeClass("invalid")
        $input_wrap.addClass("valid")
      else
        $input_wrap.removeClass("valid")
        $input_wrap.addClass("invalid")



      return valid

  return true


$("body").on "submit", "form.ajax-submit", (event)->
  event.preventDefault()
  $form = $(this)

  options = {}
  options.show_preloader = $form.hasAttribute("show-preloader")

  return if !$form.validate()

  if options.show_preloader
    $form_content = $form.find(".content")
    $form_content.addClass("invisible")
    $preloader = $form.find(".preloader")
    if $preloader.length
      $preloader.removeClass("hide")
    else
      preloader_image_url = images.form_preloader
      $preloader = $("<div class='preloader'><img src='#{preloader_image_url}'><span>Sending...</span></div>")
      $form.append($preloader)


    $form.addClass("sending")

    form_url = $form.attr("action")
    method = $form.attr("method") || 'post'
    #form_data = $form.serializeObject()
    form_data = $form.serialize()
#    $.ajax(
#      url: form_url
#      type: method
#      data: form_data
#      dataType: "json"
#      success: ()->
#        $form.removeClass("sending").addClass("sent-successfully")
#        $preloader.addClass("hide")
#
#
#    )

    success_handler = ()->
      $form.removeClass("sending").addClass("sent-successfully")
      $preloader.addClass("hide")

    $(this).ajaxSubmit({
      url: form_url
      type: method
      dataType: "json"
      success: success_handler
    })


initialize_inputs_when_autocomplete = ()->
  #console.log "hi"
  $("body .input:not(.autofilled)").each ()->
    $input_wrap = $(this)
    $input = $input_wrap.find("input")
    val = $input.val()
    if val && val.length && !$input.attr("value")
      #alert("hi: #{val}")
      $input_wrap.addClass("not-empty").removeClass("empty")
      $input_wrap.addClass("autofilled")
    else
      $input_wrap.addClass("empty").removeClass("not-empty")
    #console.log "#{val}", $input.get(0)
    #handle_keyup.apply(this)

#$(document).on "ready", ()->
#  if $(".input").length
#    setTimeout(initialize_inputs_when_autocomplete, 400)
#    setTimeout(initialize_inputs_when_autocomplete, 600)
#    setTimeout(initialize_inputs_when_autocomplete, 1000)
#    setTimeout(initialize_inputs_when_autocomplete, 2000)