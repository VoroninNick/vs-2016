class OldProject < Project
  has_one :portfolio, foreign_key: :project_id
  attr_accessible :portfolio

  delegate :avatar, :name, to: :portfolio

  def url(locale = I18n.locale)
    v = self.translations_by_locale[locale].try(:url_fragment)
    return nil if v.blank? && !portfolio

    if v.blank?
      v = portfolio.translations_by_locale[locale].url_fragment
      if !v.start_with?("/")
        v = "/#{v}"
      end
    end

    "/#{locale}/projects#{v}"
  end
end