class Project < ActiveRecord::Base
  attr_accessible *attribute_names
  PROJECT_PARTS = {case: "#project-case", ux: "#ux-and-strategy", rwd: "#responsive-web-design", seo: ".project-seo-strategy", tech: "#technical-side"}

  has_and_belongs_to_many :services
  attr_accessible :services, :service_ids

  has_and_belongs_to_many :technologies
  attr_accessible :technologies, :technology_ids

  globalize :short_name, :name, :customer_name, :url_fragment, :site_url, :awards, :project_case, :logo_and_ci, :ux_and_strategy, :responsive_web_design, :technical_side_of_project, :seo_strategy

  boolean_scope :published
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }

  boolean_scope :featured
  scope :sort_by_featured_position, -> { order("featured_position asc") }

  has_cache do
    pages :about_us, :articles, :contacts, :home, :projects, :services, :studio_life, Project.published, Article.published, Service.published
    Cms.config.provided_locales.each do |locale|
      pages "/ajax/#{locale}/projects/*"
    end
  end
  has_seo_tags
  has_sitemap_record
  has_navigation

  # attachments

  has_attached_file :home_banner_image, styles: {thumb: "400x400>"}

  has_attached_file :avatar, styles: { popup: "350x350#", projects_list: "510x510#", thumb: "100x100#" }
  has_attached_file :thumb, styles: { thumb: "100x100#" }
  has_attached_file :item_top_banner_bg_image, styles: {large: "1920x980", thumb: "400x400>"}
  has_attached_file :item_top_banner_image, styles: {thumb: "400x400>"}
  has_attached_file :vs_banner, styles: {thumb: "400x400>"}

  has_attached_file :item_bottom_banner_bg_image, styles: {large: "1920x980", thumb: "400x400>"}
  has_attached_file :item_bottom_banner_image, styles: {thumb: "400x400>"}



  has_attached_file :logo_and_ci_bg_image, styles: {thumb: "400x400>"}
  has_attached_file :ux_bg_image, styles: {thumb: "400x400>"}
  has_attached_file :rwd_bg_image, styles: {thumb: "400x400>"}
  has_attached_file :technical_side_of_project_bg_image, styles: {thumb: "400x400>"}

  [:avatar, :item_top_banner_bg_image, :item_top_banner_image, :vs_banner, :thumb, :item_bottom_banner_bg_image, :item_bottom_banner_image, :home_banner_image,
   :logo_and_ci_bg_image, :ux_bg_image, :rwd_bg_image, :technical_side_of_project_bg_image].each do |attachment_name|
    attr_accessible attachment_name
    allow_delete_attachment attachment_name
    do_not_validate_attachment_file_type attachment_name
  end

  has_images :logo_and_ci_images, styles: {thumb: "400x400>"}
  has_images :ux_images, styles: {thumb: "400x400>"}
  has_images :rwd_desktop_images, styles: {thumb: "400x400>", slide: "980x550#"}
  has_images :rwd_images, styles: {thumb: "400x400>"}



  def self.sass_option(name, default = nil, rails_admin_field_type = :string)
    opts = class_variable_get(:@@_sass_options) rescue []
    opts << {name: name, default: default, rails_admin_field_type: rails_admin_field_type}
    class_variable_set(:@@_sass_options, opts)
    field name
  end

  def self.sass_options
    class_variable_get(:@@_sass_options) rescue []
  end



  def sass_options(source = "ruby")
    #source = "db"
    opt_names = self.class.sass_options.map{|opt| opt[:name] }
    Hash[opt_names.map {|opt_name|
      puts "opt_name: #{opt_name}"
      if source == "db"
        val = self.send(opt_name)
      else
        val = specific_project_sass_options
        val = val[:options][opt_name.to_sym] if val && val[:options]
      end

      [opt_name, val]
    }.keep_if{|k, v| !v.blank? }]
  end

  def specific_project_sass_options
    if code_name == "arazzinni"
      colors = {
          black: "#212121",
          brown: "#876036",
          primary: "#876036"
      }

      options = {
          primary_color: colors[:brown],
          secondary_color: colors[:black],
          body_bg: "white",
          body_color: colors[:black],
          top_banner_title_color: colors[:black]
      }

      {options: options, colors: colors}
    elsif code_name == "10g-force"
      options = {
          :body_bg=>"#212121",
          :primary_color=>"rgb(89, 200, 230)",
          :secondary_color=>"rgb(255, 170, 44)",
          :third_color=>"rgb(239, 80, 35)",
          :button_lines_color=>"@third_color",
          :desktop_slider_background_color=>"@third_color",
          :technology_color=>"@secondary_color",
          :technology_name_color=>"white",
          :technology_svg_orbit_color=>"rgba(#fff, 0.2)",
          :project_bottom_banner_title_color=>"@third_color",
          :project_bottom_banner_description_color=>"#212121",
          :project_bottom_banner_buttons_color=>"#212121"
      }

      {options: options}
    end
  end

  sass_option :body_bg, "#212121"
  sass_option :primary_color, "red"
  sass_option :secondary_color, "blue"
  sass_option :third_color, "green"
  sass_option :body_color, "white"
  sass_option :link_hover_color, "@primary_color"
  sass_option :text_header_color, "@primary_color"
  sass_option :project_large_section_title_color, "rgba(128, 128, 128, 0.12)"
  sass_option :section_descriptive_title_color, "@primary_color"
  sass_option :button_lines_color, "@primary_color"
  sass_option :social_link_hover_bg_color, "@primary_color"


  sass_option :top_banner_title_color, "@primary_color"
  sass_option :top_banner_title_sup_color, "@primary_color"

  sass_option :top_banner_description_color, "@primary_color"
  #sass_option :project_case_section_bg_color, "none"
  #sass_option :project_case_header_color, "@text_header_color"
  #sass_option :project_case_text_color, "@body_color"
  sass_option :desktop_slider_background_color, "@primary_color"

  #sass_option :ux_and_strategy_section_bg_color, "none"
  #sass_option :ux_and_strategy_header_color, "@text_header_color"
  #sass_option :ux_and_strategy_text_color, "@body_color"






  #sass_option :seo_strategy_text_color, "@body_color"
  #sass_option :technical_side_of_project_text_color, "@body_color"
  sass_option :technology_color, "@primary_color"
  sass_option :technology_name_color, "@primary_color"
  sass_option :technology_svg_orbit_color, "@primary_color"

  sass_option :project_bottom_banner_title_color, "@primary_color"
  sass_option :project_bottom_banner_description_color, "@primary_color"
  sass_option :project_bottom_banner_buttons_color, "@primary_color"

  PROJECT_PARTS.each do |k, v|
    sass_option "#{k}_text_color".to_sym, "@body_color"
    sass_option "#{k}_header_color".to_sym, "@text_header_color"
    sass_option "#{k}_bg_color".to_sym, "inherit"
  end

  def self.project_css_mixin_options_string
    opts = sass_options
    opts.map{|opt|
      k = "$#{opt[:name].to_s}"
      has_default = opt.has_key?(:default) && opt[:default].present?
      if has_default
        default = opt[:default].gsub(/\A\@/, "$")

        "#{k}: #{default}"
      else
        k
      end


    }.join(", ")
  end

  def project_sass_options_string(source = "ruby")
    opts = sass_options(source)
    if opts.blank?
      return ""
    end

    opts.map{|k, v|
      if v.start_with?("@")
        v = opts[v.gsub(/\A\@/, "").to_sym]
      end
      "$#{k}: #{v}"
    }.join(", ")
  end

  def project_css
    opts_str = project_sass_options_string
    if opts_str.blank?
      return ""
    end

    indent = "  "


    files = ["calc_functions.sass", "detailed_css3_mixins.sass", "mixins.sass", "font_mixins.sass"]
    preloaded_sass = ""
    files.each do |f|
      preloaded_sass += File.read(Rails.root.join("app/assets/stylesheets/#{f}").to_s) + "\n"
    end

    ["theming_mixins.sass.erb"].each do |f|
      preloaded_sass += ERB.new(File.read(Rails.root.join("app/assets/stylesheets/#{f}").to_s) + "\n").result
    end

    if indent == "  "
      preloaded_sass = preloaded_sass.gsub("\t", "  ")
    end

    #mixin_src =


    body_str = "body.theme-#{code_name}"

    code = "\n#{body_str}\n#{indent}+theme(#{opts_str})"
    code += "\n#{indent}#{colors_code}"
    file_code = File.readlines(Rails.root.join("app/assets/stylesheets/themes/#{code_name}.sass"))
      .map{|s| indent + s }.join("")
    code += "\n" + file_code

    sass_code = "#{preloaded_sass}\n#{code}"
    puts "SASS code:"
    puts sass_code

    Sass.compile(sass_code, syntax: :sass, load_paths: [Rails.root.join("app/assets/stylesheets"), Rails.root.join("vendor/assets/bower_components")])
  end

  def colors_code(syntax = :sass, indent = "  ")
    colors = specific_project_sass_options
    colors = colors[:colors] if colors

    return "" if !colors || colors.blank?

    arr = colors.map{|k, v| "$#{k}_color: #{v}" }
    if syntax == :scss
      arr.join(";")
    else
      arr.join("\n#{indent}")
    end
  end

  def project_style
    css = project_css
    if css.blank?
      return ""
    end
    str = project_css.gsub("\n", "").gsub(/[ ]{0,}\{[ ]{0,}/, "{").gsub(": ", ":").gsub(/[ ]{0,}\}[ ]{0,}/, "}").gsub(";}", "}").gsub(/[ ]{0,},[ ]{0,}/, ",")
    "<style>#{str}</style>".html_safe
  end

  def url(locale = I18n.locale)
    if self.behance_url.present?
      return self.behance_url
    end
    v = self.translations_by_locale[locale].url_fragment
    if !v.start_with?("/")
      v = "/#{v}"
    end

    "/#{locale}/projects#{v}"
  end

  def self.load_data_defaults(associations = {})
    defaults = 4.times.map do |i|
      item_defaults = {}

      [:project_case, :logo_and_ci, :ux_and_strategy, :responsive_web_design, :technical_side_of_project, :seo_strategy].each do |column_name|
        I18n.available_locales.each do |locale|
          locale = locale.to_sym
          item_defaults[:translations] = {}
          item_defaults[:translations][locale] = {}
          item_defaults[:translations][locale][column_name.to_sym] = Fake.html(locale: locale)
        end

      end

      item_defaults
    end
  end

  def self.load_data(associations = {})
    defaults = self.load_data_defaults(associations)
    LoadData.load_resources(self, associations, defaults)

    self.all.each do |item|
      [:project_case, :logo_and_ci, :ux_and_strategy, :responsive_web_design, :technical_side_of_project, :seo_strategy].each do |column_name|
        I18n.available_locales.each do |locale|
          locale = locale.to_sym
          item.translations_by_locale[locale].send("#{column_name}=", Fake.html(locale: locale))
        end
      end

      item.save
    end
  end

  def short_name(locale = I18n.locale)
    v = ""
    [:short_name].each do |k|
      if v.blank?
        v = self.translations_by_locale[locale].try(k)
      else
        break
      end
    end

    [:site_url].each do |k|
      if v.blank?
        v = self.translations_by_locale[locale].try(k).try(:capitalize)
      else
        break
      end
    end

    [:short_name, :site_url, :customer_name].each do |k|
      if v.blank?
        v = self.translations_by_locale[locale].try(k)
      else
        break
      end
    end

    v
  end

  def basic_field(field_name)
    s = I18n.t("projects.#{code_name}.#{field_name}", raise: true) rescue nil
    if s.blank?
      return self.translations_by_locale[I18n.locale].try(field_name)
    end

    s
  end
  [:project_case, :logo_and_ci, :ux_and_strategy, :responsive_web_design, :technical_side_of_project].each do |m|
    define_method m do
      basic_field(m)
    end
  end

  def self.ordered_project_ids
    Project.published.sort_by_sorting_position.pluck(:id).reverse
  end

  def project_number(ids = nil)
    ids = self.class.ordered_project_ids if ids.nil?
    number = ids.map.with_index{|id, i| next nil if id != self.id; i + 1  }.select(&:present?).first
  end

  def formatted_project_number(ids = nil)
    n = project_number(ids)
    n >= 10 ? n.to_s : "0" + n.to_s
  end
end
