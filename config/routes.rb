Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    scope :services, controller: "services" do
      root action: "index", as: :services
      get ":id", action: :show, as: "service"
    end
  end

  controller :pages do
    root action: "index"

    get "test", action: "test"
  end
end
