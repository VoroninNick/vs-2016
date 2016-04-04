Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  controller :pages do
    root action: "index"

    get "test", action: "test"
  end
end
