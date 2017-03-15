window.set_input_presence_classes = ()->
  $input_wrap = $(this)
  value = $input_wrap.find("input, textarea").val()

  empty = !value || !value.length
  add_presence_class = if empty then "empty" else "not-empty"
  remove_presence_class = if empty then "not-empty" else "empty"
  $input_wrap.changeClasses(add_presence_class, remove_presence_class)



$document.on "focusin focusout", ".input", (e)->
  $input_wrap = $(this)

  if e.type == 'focusin'
    $input_wrap.addClass("focus")
  else if e.type == 'focusout'
    $input_wrap.removeClass('focus')


$document.on "ready page:load", ()->
  $("select").each ()->
#init_selectize.call(this)
    $(this).niceSelect()



$document.on "submit", "form.ajax-submit", ()->
  $form = $(this)
  $form.ajaxSubmit()


$document.on "ready page:load", ()->
  $(".input-phone:not(.mask-initialized)").each(
    ()->
      $input_wrap = $(this)
      $input_wrap.addClass("mask-initialized")
      $input_wrap.find("input").mask("+99 (999) 999 99 99")
  )

$document.on "keyup blur change", ".input", ()->
  $input = $(this)
  if $input.filter("[validation]").length
    validate_input.call($input, true)
    console.log("HELLO")
  else
    set_input_presence_classes.call($input)



basic_form_submit_handler = (e, options = {})->
  e.preventDefault()
  $form = $(this)
  $form_inputs = $form.find(".input[validation]")
  valid = validate_inputs.call($form_inputs, true)
  is_contact_form = $form.hasClass('contact-form')
  if !valid && is_contact_form
    window.header_frozen = true

    current_scroll_top = $("body").scrollTop() || $(window).scrollTop()
    new_scroll_top = $form.offset().top
    new_scroll_top = $(".form-and-title-row").offset().top
    if new_scroll_top < current_scroll_top
      $("body, html").animate({scrollTop: new_scroll_top}, {
        duration: 400,
        complete: ()->
          window.header_frozen = false

      } )
  if valid
    form_data = $form.serializeArray()
    clear_form.call($form)
    if is_contact_form
      open_contact_form_success_popup()
    $form.addClass("sending")

    url = $form.attr("ation") || $form.attr("data-url")

    $.ajax({
      url: url
      type: 'post'
      data: form_data
    })

  if options.handler
    handler.call(this, e, valid)

$document.on "submit", ".contact-form, .order-popup form", basic_form_submit_handler
###
$document.on "submit", ".order-popup form", (e)->
  basic_form_submit_handler(e,
    handler: (e, valid)->
      if valid
        $(this).closest(".order-popup").addClass("send")
  )
###

clear_form = ()->
  $form = $(this)
  $form.find(".input").find("input, textarea").val("")


$document.on "click", ".contact-form-success-popup .popup-overlay, .contact-form-success-popup .popup-close-button", window.close_contact_form_success_popup

###
$document.on "keyup keydown", "textarea", ()->
  textareaAutoResize($(this))
###

###
setInterval(
  ()->
    $("textarea").css({height: 28 * rand(1, 10)})

  1000)
###