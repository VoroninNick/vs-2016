class PagesController < ApplicationController
  before_action :set_page_instance, except: [:index]

  def index
    @services = Service.published.sort_by_sorting_position.includes(translations: {})
    #@enable_tubular = !File.exists?("/media/data/pasha")
    #@enable_tubular = request.host != "localhost"
    @enable_tubular = false
    @footer = false

    #@featured_projects = [Project.first]

    @short_video_key = "o1prvOC1_90"
    @full_video_key = "DbTt45aSX0U"

    set_project_banners

    set_page_metadata("home")

    @home_scroll_down_text = "<span class='line-through'>dare to</span> see our projects"
  end

  def about_us
    @video_key = "DbTt45aSX0U"
    #@video_key = "CguR68fwyyA"
    @page_banner_template = "about_us_banner"
    @page_banner = {
        bg_image: 'banners/inner-page-main-banners-v1-about-us.jpg',
        title: "About",
        numbers: [
            {number: 10, number_description: "years of experience"},
            {number: 8, number_description: "team members"},
            {number: 1, number_description: "goal"}
        ],
        scroll_down_title: "take a look"
    }

    @team_members = Member.all.includes(:translations)

    #load_logos_from_assets

    @clients = Client.published.includes(:translations)

    @slides = AboutSlide.published.sort_by_sorting_position

    @principles = [{name: "Research", description: "<p>Logos and branding are so important.</p>" * 3, icon_path: "svg/vs-about-icon-research.svg"},
                   {name: "Planning", description: "Logos and branding are so important. In a big part of the world. "*5, icon_path: "svg/vs-about-icon-planning.svg"},
                   {name: "Execution", description: "Logos and branding are so important. In a big part of the world", icon_path: "svg/vs-about-icon-execution.svg"}]
  end



  def contacts
    @page_banner_template = "contacts_banner"
    @page_banner = {
        bg_image: 'banners/inner-page-main-banners-v1-contacts.jpg',
        title: "Contacts",
        numbers: [

        ],
        scroll_down_title: "more information"
    }

    @offices = [
        {country: "Ukraine",
         phones: ["+38 (050) 417 07 28", "+38 (032) 240 33 50"],
         emails: [{email: "nick@voroninstudio.eu", description: "financial and art questions"},
                  {email: "office@voroninstudio.eu", description: "office"},
                  {email: "support@voroninstudio.eu", description: "technical support questions"}],
         address: "Lukianovycha Str. 11, Lviv",
         map: {
             center: "49.833188, 24.020121",
             location: "49.833188, 24.020121"
         },


        },
        {
            country: "USA",
            phones: ["+1 (471) 254 1111"],
            emails: [{email: "tomson@voroninstudio.eu", description: "financial and art questions"},
                     {email: "office-usa@voroninstudio.eu", description: "office"}
            ],
            address: "350 Fifth Avenue, New York",
            map: {
                center: "40.748571, -73.985645",
                location: "40.748571, -73.985645"
            }
        }
    ]

    @hire_us_form = HireUsRequest.new


  end

  def studio_life
    @life_entries = LifeEntry.published.includes(:translations)
    @life_entries_count = LifeEntry.published.count

    @page_banner = {
        bg_image: 'banners/inner-page-main-banners-v1-expertise.jpg',
        title: "Life",
        numbers: [
            { number: @life_entries_count, number_description: "moments to remember"}
        ],
        scroll_down_title: "view all"
    }

  end

  private
  def set_page_instance(key = action_name)
    set_page_metadata(key)
  end

  def set_project_banners
    @projects = Project.limit(3).includes(:translations, services: [:translations])
    @project_banners = @projects.map do |p|
      project_translation = p.translations_by_locale[I18n.locale]
      image_url = nil
      image_url = p.home_banner_image.url if p.home_banner_image.exists?
      image_url = p.item_top_banner_image.url if image_url.blank? &&  p.item_top_banner_image.exists?

      {
          title: project_translation.banner_title,
          title_sup: project_translation.banner_title_sup,
          short_description: project_translation.short_description,
          image_url: image_url,
          service_icons: p.services.map {|s| {icon_path: s.icon.path, service_url: s.url }  },
          key: p.code_name,
          swing: p.show_swing_on_home_banner,
          project_url: p.url
      }
    end
  end

  def load_logos_from_assets
    @logos = Dir[Rails.root.join("app/assets/images/trust_companies/*/original/*.svg")]
                 .map do |path|
      s = path.to_s
      base_path = Rails.root.join("app/assets/images/").to_s
      s[base_path.length, s.length]
    end.take(40)
  end
end