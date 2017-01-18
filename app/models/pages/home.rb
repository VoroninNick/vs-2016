module Pages
  class Home < Page
    def url(locale = I18n.locale)
      "/#{locale}"
    end
  end
end
