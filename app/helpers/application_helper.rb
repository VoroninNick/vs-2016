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
end
