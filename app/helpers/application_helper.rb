module ApplicationHelper
  def main_menu_items
    menu_item_keys = %w(about_us projects services articles studio_life contacts)
    menu_items = menu_item_keys.map{|k|
      url = Pages.send(k).url;
      request_url = request.path
      active = url == request_url
      has_active = false
      if k == "services" && @service
        has_active = true
      elsif k == "projects" && (@project || @category)
        has_active = true
      elsif k == "articles" && @article
        has_active = true
      end
      {title: t("components.menu.title.#{k}"), sub_label: t("components.menu.sub_label.#{k}"), url: url, active: active, has_active: has_active}
    }
  end

  # def inline_svg(path, transform_params={})
  #   if !File.exists?(path)
  #     path = Rails.root.join("app/assets/images").join(path)
  #   end
  #   if !File.exists?(path)
  #     return "not_found"
  #   end
  #   InlineSvg::TransformPipeline.generate_html_from(path, transform_params).html_safe
  # end

  def contacts_main_phones
    footer_phones
  end

  def footer_phones
    ["+38 (050) 417 07 28"]
  end

  def footer_emails
    ["office@voroninstudio.eu"]
  end

  def social_links
    [:behance, :facebook, :google_plus, :instagram].map{|h| {icon: "svg/social2/#{h}.svg", url: "#"} }
  end

  def footer_social_links
    social_links[0..1]
  end

  def formatted_phone_number(phone)
    phone.gsub(/\(/, "<span class='bracket bracket-open'>(</span>").gsub(/\)/, "<span class='bracket bracket-close'>)</span>").html_safe
    #parts = phone.split(/[\(\)]/)

  end

  def youtube_video_iframe(video_key, iframe_id, options = {}, html_safe = true)
    defaults = {
        modestbranding: 1,
        controls: 0,
        showinfo: 0,
        wmode: "transparent",
        enablejsapi: 1,
        widgetid: 1,
        autoplay: 1,
        autohide: 1,
        loop: 1,
        version: 3,
        playlist: video_key,
        rel: 0
    }
    options = defaults.merge(options)
    iframe_url_options = options

    iframe_url_options_str = iframe_url_options.map{|k, v| "#{k}=#{v}" }.join("&")
    iframe_url = "https://www.youtube.com/embed/#{video_key}?#{iframe_url_options_str}"
    iframe_html_attributes = {
        id: iframe_id,
        frameborder: 0,
        allowfullscreen: 1,
        title: "YouTube video player",
        width:  2048, # 1280
        height: 1200, # 720
        src: iframe_url,
        class: "youtube-video"
    }

    iframe_html_attributes_str = iframe_html_attributes.map{|k, v| "#{k}='#{v}'" }.join(" ")
    str = "<iframe #{iframe_html_attributes_str}></iframe>"
    if html_safe
      str.html_safe
    else
      str
    end
  end

  def youtube_video_iframe_block(video_key, iframe_id, options = {}, html_safe = true)
    iframe = youtube_video_iframe(video_key, iframe_id, options, false)
    wrap_id = "#{iframe_id}-wrap"
    overlay_id = "#{iframe_id}-overlay"
    wrap_class = "youtube-video-wrap"
    overlay_class = "youtube-video-overlay"
    str = "<div class='#{wrap_class}' id='#{wrap_id}'>#{iframe}<div class='#{overlay_class}' id='#{overlay_id}'></div></div>"
    if html_safe
      str.html_safe
    else
      str
    end
  end

  def youtube_video_popup(video_key, iframe_id, options = {}, html_safe = true)
    block = youtube_video_iframe_block(video_key, iframe_id, options, false)
    popup_id = "#{iframe_id}-popup"
    popup_close_button_id = "#{iframe_id}-popup-close-button"
    popup_close_button = "<div class='youtube-video-popup-close-button' id='#{popup_close_button_id}'>#{embedded_svg_from_assets("svg/vs-projects-popup-close-icon")}</div>"
    str = "<div class='youtube-video-popup' id='#{popup_id}'>#{block}#{popup_close_button}</div>"
    if html_safe
      str.html_safe
    else
      str
    end
  end

  def project_asset_path(rel_path)
    asset_path("projects/#{@project.code_name}/#{rel_path}")
  end
end

