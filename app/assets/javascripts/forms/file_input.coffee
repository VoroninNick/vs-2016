$document.on "change", "input[type=file]", ()->
  $input = $(this)
  $input_wrap = $input.closest(".input")
  $button = $input_wrap.find("label.btn")
  $button_text = $button.children()
  full_file_name = $input.val()
  full_file_name_parts = full_file_name.split("\\")
  file_name = full_file_name_parts[full_file_name_parts.length - 1]
  valid_formats = "doc docx pdf jpg".split(" ")
  file_name_parts = file_name.split(".")
  if file_name_parts.length
    ext = (file_name_parts[file_name_parts.length - 1]).toLowerCase()
  else
    ext = null

  valid_format = ext && valid_formats.includes(ext)
  alert("valid_format: #{valid_format}")

  if !valid_format
    $input.val("")

  if file_name && file_name.length
    $file_name = $input_wrap.find("div.file-name")
    $button_text.text("File uploaded")
    $file_name.text(file_name)
  else
    $button_text.text("Upload file")
    $file_name.text("File is not selected")
