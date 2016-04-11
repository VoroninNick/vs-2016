RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

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

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.include_models Service

  config.model Service do
    field :published
    field :translations, :globalize_tabs
    field :icon, :paperclip
    field :home_bg
    field :list_image
  end

  config.model_translation Service do
    field :locale, :hidden
    field :name
    field :descriptive_name
    field :url_fragment
    field :description
    field :long_description

    field :content, :ck_editor
  end
end
