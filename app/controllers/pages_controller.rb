class PagesController < ApplicationController
  before_action :set_page_instance, except: [:index]

  caches_page :index, :about_us, :contacts, :studio_life

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

    @home_scroll_down_text = I18n.t("pages.home.scroll-down").html_safe
  end

  def about_us
    @video_key = "DbTt45aSX0U"
    #@video_key = "CguR68fwyyA"
    @page_banner_template = "about_us_banner"
    @page_banner = {
        bg_image: 'banners/inner-page-main-banners-v1-about-us.jpg',
        title: t("pages.about_us.banner.title"),
        numbers: [
            {number: 10, number_description: t("pages.about_us.banner.years-of-experience")},
            {number: 8, number_description: t("pages.about_us.banner.team-members")},
            {number: 1, number_description: t("pages.about_us.banner.goal")}
        ],
        scroll_down_title: "take a look"
    }

    @team_members = Member.published.includes(:translations)

    #load_logos_from_assets

    @clients = Client.published.includes(:translations)

    @slides = AboutSlide.published.sort_by_sorting_position

    @principles = [{name: t("pages.about_us.principles.principle-1.name"), description: t("pages.about_us.principles.principle-1.description"), icon_path: "svg/vs-about-icon-research.svg"},
                   {name: t("pages.about_us.principles.principle-2.name"), description: t("pages.about_us.principles.principle-2.description"), icon_path: "svg/vs-about-icon-planning.svg"},
                   {name: t("pages.about_us.principles.principle-3.name"), description: t("pages.about_us.principles.principle-3.description"), icon_path: "svg/vs-about-icon-execution.svg"}]
  end



  def contacts
    @page_banner_template = "contacts_banner"
    @page_banner = {
        bg_image: 'banners/inner-page-main-banners-v1-contacts.jpg',
        title: t("pages.contacts.banner.title"),
        numbers: [

        ],
        scroll_down_title: "more information"
    }

    @offices = [
        {country: t("pages.contacts.ukraine.country"),
         phones: ["+38 (050) 417 07 28", "+38 (032) 240 33 50"],
         emails: [{email: "nick@voroninstudio.eu", description: t("pages.contacts.ukraine.emails-description.nick")},
                  {email: "office@voroninstudio.eu", description: t("pages.contacts.ukraine.emails-description.office")},
                  {email: "support@voroninstudio.eu", description: t("pages.contacts.ukraine.emails-description.support")}],
         address: t("pages.contacts.ukraine.address"),
         map: {
             center: "49.833188, 24.020121",
             location: "49.833188, 24.020121"
         },


        },
        {
            country: t("pages.contacts.usa.country"),
            phones: ["+1 (471) 254 1111"],
            emails: [{email: "tomson@voroninstudio.eu", description: t("pages.contacts.usa.email-description.tomson")},
                     {email: "office-usa@voroninstudio.eu", description: t("pages.contacts.usa.email-description.office")}
            ],
            address: t("pages.contacts.usa.address"),
            map: {
                center: "40.748571, -73.985645",
                location: "40.748571, -73.985645"
            }
        }
    ]


  end

  def studio_life
    @life_entries = LifeEntry.published.includes(:translations).order("release_date desc")
    @life_entries_count = LifeEntry.published.count

    @page_banner = {
        bg_image: 'banners/life-v2.jpg',
        title: t("pages.life.banner.title"),
        numbers: [
            { number: @life_entries_count, number_description: t("pages.life.banner.moments-to-remember")}
        ],
        scroll_down_title: "view all"
    }

  end

  private
  def set_page_instance(key = action_name)
    set_page_metadata(key)
  end

  def set_project_banners
    @projects = Project.featured.sort_by_featured_position.limit(3).includes(:translations, services: [:translations])
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
          service_icons: p.services.map {|s|
            {icon_path: s.icon_path,
             #service_url: s.url,
             service_url: project_or_category_path(s.url_fragment),
             icon_title: s.name }
          },
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