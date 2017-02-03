module AssetPathHelper
  def self.included(base)
    methods = self.instance_methods
    methods.delete(:included)
    if base.respond_to?(:helper_method)
      base.helper_method methods
    end
  end

  def asset_path(rel_path)
    puts "rel_path: #{rel_path}"
    extname = File.extname(rel_path).gsub(/\A\./, "")
    rel_path_without_ext = rel_path.gsub(/\.[a-zA-Z0-9]+\Z/, "")
    root_path = Rails.root.join("public/assets")
    if extname == "js"
      extname = "{js,coffee}"
    end

    if extname == "css"
      extname = "{css,scss,sass}"
    end

    s = Dir[root_path.join(rel_path_without_ext + "-*.#{extname}")].first
    if !s
      puts "path: #{rel_path_without_ext.inspect}; ext: #{extname.inspect}"
      s = (Dir[Rails.root.join("app/assets/**/#{rel_path_without_ext}.#{extname}")].any? ? "/assets/#{rel_path}" : "/#{rel_path}" )
    end

    #rel_path
  end

  def javascript_include_tag(file_name = "application", options = {})
    options.stringify_keys!
    options["src"] ||= asset_path("#{file_name}.js")
    content_tag("script", nil, options).html_safe
  end

  def stylesheet_link_tag(file = "application", options = {})
    options.stringify_keys!
    options["href"] ||= asset_path("#{file}.css")
    options["rel"] ||= "stylesheet"
    options["media"] ||= "screen"
    content_tag("link", nil, options).html_safe
  end
end