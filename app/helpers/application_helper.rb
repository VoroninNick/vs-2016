module ApplicationHelper
  def main_menu_items
    menu_items = [
        { title: "who", sub_label: "about the studio", url: Pages.about_us.url },
        { title: "how", sub_label: "portfolio" },
        { title: "what", sub_label: "our services", url: Pages.services.url },
        { title: "when", sub_label: "publications", url: Pages.articles.url },
        { title: "life", sub_label: "studio life" },
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
end
