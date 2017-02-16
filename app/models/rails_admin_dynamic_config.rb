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
            field :email_receivers, :text
          end
        end

        config.include_models Service, Article, Cms::Tag, Attachable::Asset, User, AboutSlide, Member, Project

        config.model Attachable::Asset do
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
          field :translations, :globalize_tabs
        end

        config.model_translation Cms::Tag do
          field :locale, :hidden
          field :name
          field :url_fragment
        end

        config.model AboutSlide do
          nestable_list({position_field: :sorting_position})
          edit do
            field :published
            field :image
          end
        end

        config.model Member do
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
          nestable_list({position_field: :sorting_position})
          field :published
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

          #group :item_top_banner_image do
          #  field :item_top_banner_bg_image
          #  field :item_top_banner_image
          #end

          #group :item_bottom_banner_image do
          #  field :item_bottom_banner_bg_image
          #  field :item_bottom_banner_image
          #end

          #group :item_home_banner do
          #  field :home_banner_image
          #  field :show_swing_on_home_banner
          #end

          #group :project_content_images do
          #  field :logo_and_ci_bg_image
          #  field :logo_and_ci_images
          #  field :ux_bg_image
          #  field :ux_images
          #  field :rwd_bg_image
          #  field :rwd_images
          #  field :technical_side_of_project_bg_image
          #end

          #group :site_preview_images do
          #  field :rwd_desktop_images
          #end

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

        config.model Technology do
          nestable_list({position_field: :sorting_position})

          field :name
          field :site_url
          field :icon
          field :projects
        end

        config.include_models Client
        config.model Client do
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
            field :seo_tags
          end
        end
      end
    end
  end
end