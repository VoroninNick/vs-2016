module ApplicationHelper
  def main_menu_items
    menu_items = [
        { title: "who", sub_label: "about the studio" },
        { title: "how", sub_label: "portfolio" },
        { title: "what", sub_label: "our services" },
        { title: "when", sub_label: "publications" },
        { title: "life", sub_label: "studio life" },
        { title: "where", sub_label: "contacts" }
    ]
  end

  def inline_svg(path, transform_params={})
    if !File.exists?(path)
      path = Rails.root.join("app/assets/images").join(path)
    end
    if !File.exists?(path)
      return "not_found"
    end
    InlineSvg::TransformPipeline.generate_html_from(path, transform_params).html_safe
  end
end
