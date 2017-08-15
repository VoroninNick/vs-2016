def host?(*hosts)


  if hosts.blank? || !defined?(REQUEST_HOST)
    return true
  end

  hosts.include? REQUEST_HOST
end

def sass_options_group
  group :sass_options do
    Project.sass_options.each do |option|
      field option[:name], option[:rails_admin_field_type] do
        label "@#{name}"
        html_attributes do
          {
              required: required?,
              maxlength: length,
              size: input_size,
              placeholder: Project.sass_options.select{|opt| opt[:name] == name.to_sym }.first[:default]
          }
        end
      end
    end
  end
end

module RailsAdminDynamicConfig
  class << self
    def configure_rails_admin(initial = true)
      RailsAdmin.config do |config|

        ### Popular gems integration

        ## == Devise ==
        config.authenticate_with do
          warden.authenticate! scope: :user
        end
        config.current_user_method(&:current_user)

        ## == Cancan ==
        # config.authorize_with :cancan

        ## == Pundit ==
        # config.authorize_with :pundit

        ## == PaperTrail ==
        # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

        ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration



        if initial
          config.actions do
            dashboard                     # mandatory
            index                         # mandatory
            new
            export
            bulk_delete
            show
            edit
            delete
            show_in_app
            nestable do
              only [AboutSlide, Project, Technology]
            end

            ## With an audit adapter, you can add:
            # history_index
            # history_show
          end
        end

        config.navigation_static_links = {
            locales: "/file_editor#{Rails.root.join("config/locales")}"
        }

        config.navigation_labels do
          {
              feedbacks: 100,
              home: 200,
              about_us: 300,
              projects: 400,
              portfolio: 420,
              remote_projects: 440,
              services: 500,
              articles: 600,
              life: 700,
              contacts: 800,
              tags: 1000,
              users: 1100,
              settings: 1200,
              pages: 1300,
              assets: 1400
          }
        end

        config.include_models Cms::MetaTags
        config.model Cms::MetaTags do
          visible false
          field :translations, :globalize_tabs
        end

        config.model_translation Cms::MetaTags do
          field :locale, :hidden
          field :title
          field :description
          field :keywords
        end


        config.include_models Technology

        config.include_models HireUsRequest, JoinUsRequest, FormConfigs::HireUsRequest, FormConfigs::JoinUsRequest

        config.model HireUsRequest do
          navigation_label_key(:feedbacks, 1)

          field :name
          field :organization_name
          field :phone
          field :email
          field :budget_range
          field :created_at
          field :locale
          field :referer
          field :session_id
        end

        config.model JoinUsRequest do
          navigation_label_key(:feedbacks, 1)

          field :name
          field :organization_name
          field :phone
          field :email
          field :budget_range
          field :description
          field :locale
          field :referer
          field :session_id
        end

        [FormConfigs::HireUsRequest, FormConfigs::JoinUsRequest].each do |m|
          config.model m do
            navigation_label_key(:settings)
            field :email_receivers, :text
          end
        end

        config.include_models Service, Article, Cms::Tag, Attachable::Asset, User, AboutSlide, Member, Project, BehanceProject

        config.model Attachable::Asset do
          navigation_label_key(:assets, 1)
          edit do
            field :data
            field :translations, :globalize_tabs
          end
        end

        config.model_translation Attachable::Asset do
          field :locale, :hidden
          field :data_alt
        end

        config.model User do
          navigation_label_key(:users, 1)
          field :email
          field :password
          field :password_confirmation

          field :translations, :globalize_tabs
        end

        config.model_translation User do
          field :locale, :hidden
          field :name
        end

        config.model Service do
          navigation_label_key(:services, 1)

          field :published
          field :translations, :globalize_tabs
          #field :icon, :paperclip
          field :home_bg
          field :list_image
          field :projects
          field :seo_tags
        end

        config.model_translation Service do
          field :locale, :hidden
          field :name
          field :descriptive_name
          field :portfolio_filter_name
          field :url_fragment
          field :description
          field :long_description

          field :content, :ck_editor
        end

        config.model Article do
          navigation_label_key(:articles, 1)
          field :published
          field :translations, :globalize_tabs
          field :avatar
          field :release_date
          field :tags
          field :authors
          field :seo_tags
        end

        config.model_translation Article do
          field :locale, :hidden
          field :name
          field :url_fragment
          field :content, :ck_editor
        end

        config.model Cms::Tag do
          navigation_label_key(:tags)

          field :translations, :globalize_tabs
        end

        config.model_translation Cms::Tag do
          field :locale, :hidden
          field :name
          field :url_fragment
        end

        config.model AboutSlide do
          navigation_label_key(:about_us, 1)
          nestable_list({position_field: :sorting_position})
          edit do
            field :published
            field :image
          end
        end

        config.model Member do
          navigation_label_key(:about_us, 1)
          field :published
          field :image
          field :translations, :globalize_tabs
        end

        config.model_translation Member do
          nestable_list({position_field: :sorting_position})
          edit do
            field :locale, :hidden
            field :name
            field :role
            field :few_words_about
          end
        end

        config.model Project do
          navigation_label_key(:projects, 1)
          nestable_list({position_field: :sorting_position})
          field :published
          field :behance_url
          field :featured
          field :featured_position
          field :code_name
          field :released_on
          field :translations, :globalize_tabs
          #field :project_technologies
          field :services
          field :technologies
          group :avatars do
            field :avatar do
              help "used in projects list page and popup"
            end
            field :thumb do
              help "used in prev/next navigation between projects above footer in project page"
            end
          end

          group :item_top_banner_image do
           field :item_top_banner_bg_image
           field :item_top_banner_image
          end

          group :item_bottom_banner_image do
           field :item_bottom_banner_bg_image
           field :item_bottom_banner_image
          end

          group :item_home_banner do
           field :home_banner_image
           field :show_swing_on_home_banner
          end

          group :project_content_images do
           field :logo_and_ci_bg_image
           field :logo_and_ci_images
           field :ux_bg_image
           field :ux_images
           field :rwd_bg_image
           field :rwd_images
           field :technical_side_of_project_bg_image
          end

          group :site_preview_images do
           field :rwd_desktop_images
          end

          #sass_options_group

          group :seo do
            field :seo_tags
          end
        end

        config.model_translation Project do
          field :locale, :hidden
          field :name
          field :url_fragment
          field :customer_name
          field :site_url
          field :short_name
          field :banner_title
          field :banner_title_sup
          field :short_description
          field :awards
          field :project_case, :ck_editor
          field :logo_and_ci, :ck_editor
          field :ux_and_strategy, :ck_editor
          field :responsive_web_design, :ck_editor
          field :technical_side_of_project, :ck_editor
          field :seo_strategy, :ck_editor

        end

        config.model BehanceProject do
          navigation_label_key(:projects, 1)
          nestable_list({position_field: :sorting_position})
          field :published
          field :behance_url
          field :released_on
          field :translations, :globalize_tabs
          field :services
          field :technologies
          group :avatars do
            field :avatar do
              help "used in projects list page and popup"
            end
            field :thumb do
              help "used in prev/next navigation between projects above footer in project page"
            end
          end


          #sass_options_group


        end

        config.model Technology do
          navigation_label_key(:projects, 2)
          nestable_list({position_field: :sorting_position})

          field :name
          field :site_url
          field :icon
          field :projects
        end

        config.include_models Client
        config.model Client do
          navigation_label_key(:about_us, 1)

          field :published
          field :name
          #field :short_description
          field :avatar
          field :no_follow_link
        end

        config.model_translation Client do
          field :locale, :hidden
          field :name
          field :short_description
          field :url
          field :avatar_alt
        end

        config.include_models LifeEntry

        config.model LifeEntry do
          navigation_label_key(:life, 1)
          #nestable_list({position_field: :sorting_position})

          field :published
          field :image
          field :post_link
          field :release_date
          field :translations, :globalize_tabs
        end

        config.model_translation LifeEntry do
          field :locale, :hidden
          field :description
        end

        page_models = [Pages::AboutUs, Pages::Articles, Pages::Contacts, Pages::Home, Pages::Projects, Pages::Services, Pages::StudioLife]
        config.include_models *page_models
        page_models.each do |m|
          config.model m do
            navigation_label_key(:pages)
            field :seo_tags
          end
        end

        config.include_models Portfolio, PortfolioBanner
        config.model Portfolio do
          navigation_label_key(:portfolio, 1)

          field :published
          field :translations, :globalize_tabs

          group :avatar_image_data do
            field :avatar do
              #label 'Изображение'
              #help 'Минимальное расширение изображения должно быть 716х716! Изображение должно быть цветным!'
            end

            field :avatar_file_name_fallback
          end

          field :portfolio_banner

          group :thanks_image_data do
            field :thanks_image
            field :thanks_image_file_name_fallback
          end

          field :release
          field :seo_tags
        end

        config.model_translation Portfolio do
          field :locale
          field :published
          field :name
          field :url_fragment
          field :task
          field :result, :ck_editor
          #field :process, :ck_editor
          #field :live, :ck_editor
          field :description, :ck_editor
          field :thanks_to
          field :avatar_alt
        end

        config.model PortfolioBanner do
          navigation_label_key(:portfolio, 2)

          field :published

          field :name do
            help 'внутреннее имя'
          end

          field :translations, :globalize_tabs


          group :image_data do
            field :background do
              label 'фоновая картинка'
              help 'на всю ширину екрана'
            end
            field :background_file_name_fallback
          end


          field :portfolio do
            help 'использовать баннер для указанного проекта'
          end
        end

        config.model_translation PortfolioBanner do
          field :locale
          field :published
          field :title, :ck_editor
          field :description, :ck_editor
        end


      end
    end
  end
end