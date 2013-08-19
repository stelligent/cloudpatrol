CloudpatrolRails::Application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :settings, except: [ :new, :edit ]
    controller :commands, path: "commands" do
      get "" => :index, as: "commands"
      get :schedule, as: "schedule"
      get :unschedule, as: "unschedule"
      get ":class/:method" => :perform, as: "perform"
    end
  end

  controller :commands, path: "commands" do
    get "" => :index, as: "commands"
    get :schedule, as: "schedule"
    get :unschedule, as: "unschedule"
    get ":class/:method" => :perform, as: "perform"
  end

  controller :sessions do
    get "login" => :new
    post "login" => :create
    get "logout" => :destroy
  end

  resources :settings, except: [ :new, :edit ]
  resources :logs, only: [ :index ]
  resource :profile, controller: :users, only: [ :show, :edit, :update ]

  controller :static_pages do

    # temporary fix, remove when favicon is made
    get "favicon.ico" => :favicon
    get "apple-touch-icon.png" => :favicon
    get "apple-touch-icon-precomposed.png" => :favicon

    get :help
    root to: :root
  end
end
