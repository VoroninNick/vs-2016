Rails.application.routes.draw do
  controller :pages do
    root action: "index"

    get "test", action: "test"
  end
end
