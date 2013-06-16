Cloudpatrol::Application.routes.draw do
  controller :sessions do
    get "login" => :new
    post "login" => :create
    get "logout" => :destroy
  end

  resources :settings, except: [ :show ]

  get "favicon.ico" => "static_pages#favicon"

  root to: "static_pages#root"
end
