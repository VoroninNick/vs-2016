module ApplicationHelper
  def main_menu_items
    menu_items = [
        { title: "who", sub_label: "about the studio", url: Pages.about_us.url },
        { title: "how", sub_label: "portfolio", url: projects_path },
        { title: "what", sub_label: "our services", url: Pages.services.url },
        { title: "when", sub_label: "publications", url: Pages.articles.url },
        { title: "life", sub_label: "studio life" , url: Pages.studio_life.url},
        { title: "where", sub_label: "contacts", url: Pages.contacts.url }
    ]
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
    [{icon: "1-fb"}, {icon: "2-g"}, {icon: "3-insta"}, {icon: '4-linkedin'}, {icon: "6-behance"}, {icon: "7-youtube"}].map{|h| {icon: "svg/social/#{h[:icon]}.svg", url: "#"} }
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
        controls: 0,
        showinfo: 0,
        modestbranding: 1,
        wmode: "transparent",
        enablejsapi: 1,
        widgetid: 1,
        autoplay: 1,
        autohide: 1,
        loop: 1,
        version: 3,
        playlist: video_key
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
end

