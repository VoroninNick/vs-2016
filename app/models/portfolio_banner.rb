class PortfolioBanner < ActiveRecord::Base
  globalize :title, :description

  has_cache do
    pages self.portfolio
  end

  belongs_to :portfolio

  image :background,
        styles: {
            full_width: {
              processors: [:thumbnail, :optimizer_paperclip_processor],
              geometry: '1980x420#',
              optimizer_paperclip_processor: {  }
            }
        },
        url: '/assets/portfolio_banners/:id/:style/:basename.:extension',
        path: ':rails_root/public/:url'


end