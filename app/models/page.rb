class Page < Cms::Page
  def url(locale = I18n.locale)
    v = self.translations_by_locale[locale].try(:url)
    if v.blank?
      v = self.class.name.gsub(/\APages\:\:/, "").underscore
    end

    if !v.start_with?("/")
      v = "/#{v}"
    end

    "/#{locale}#{v}"
  end
end