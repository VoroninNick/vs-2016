Rails.application.routes.draw do
  controller :pages do
    root action: "index"
  end
end
