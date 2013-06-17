Cloudpatrol::Application.routes.draw do
  controller :sessions do
    get "login" => :new
    post "login" => :create
    get "logout" => :destroy
  end

  resources :settings, except: [ :show ]

  controller :static_pages do
    get "favicon.ico" => :favicon
    root to: :root
  end
end
