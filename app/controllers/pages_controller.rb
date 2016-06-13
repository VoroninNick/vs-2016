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
    @page_banner_template = "contacts_banner"
    @page_banner = {
        bg_image: 'banners/services.jpg',
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
            map: {location: "40.748571, -73.985645"}
        }
    ]


  end

  private
  def set_page_instance(key = action_name)
    set_page_metadata(key)
  end
end