if ENV['imagemagick_path'].present?
  Paperclip.options[:command_path] = ENV['imagemagick_path']
end