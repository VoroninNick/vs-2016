class Portfolio < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :url_fragment, :task, :result, :process, :live, :description, :thanks_to, :avatar_alt

  boolean_scope :published
  scope :order_by_date, -> { order('release desc') }
  default_scope do
    order_by_date
  end

  belongs_to :project, foreign_key: :project_id, class_name: OldProject

  has_seo_tags
  has_sitemap_record
  has_cache do
    pages self, Portfolio.published
  end

  has_one    :portfolio_banner
  accepts_nested_attributes_for :portfolio_banner

  attr_accessible :portfolio_banner, :portfolio_banner_attributes

  image :avatar,
        styles: {
          thumb: {
              geometry: '100x100#'
          },
          popup: {
              geometry: '350x350#',
          },
          projects_list: {
              geometry: '510x510#',
          },
        },
        url: '/system/portfolios/:id/:style/:basename.:extension',
        path: ':rails_root/public/:url'

  image :thanks_image, styles: { :big => '700x700>', :thumb => '300x300>' },
        url: '/system/portfolios/:id/thanks_image/:style/:basename.:extension',
        path: ':rails_root/public/assets/portfolios/:id/thanks_image/:style/:basename.:extension'


end