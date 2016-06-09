class PagesController < ApplicationController
  before_action :set_page_instance, except: [:index]

  def index
    @services = Service.published.sort_by_sorting_position
    @enable_tubular = !File.exists?("/media/data/pasha")
    @footer = false

    set_page_metadata("home")
  end

  def about_us
    @page_banner = {
        bg_image: 'banners/services.jpg',
        title: "About",
        numbers: [
            {number: 10, number_description: "years of experience"},
            {number: 8, number_description: "team members"},
            {number: 1, number_description: "goal"}
        ],
        scroll_down_title: "take a look"
    }

    @team_members = Member.all
    @logos = Dir[Rails.root.join("app/assets/images/trust_companies/*/original/*.svg")]
                 .map do |path|
      s = path.to_s
      base_path = Rails.root.join("app/assets/images/").to_s
      s[base_path.length, s.length]
    end.take(40)

    @slides = AboutSlide.published.sort_by_sorting_position
  end

  def contacts

  end

  private
  def set_page_instance(key = action_name)
    set_page_metadata(key)
  end
end