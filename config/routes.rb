CloudpatrolRails::Application.routes.draw do
  controller :commands, path: "commands" do
    get "" => :index, as: "commands"
    get ":class/:method" => :perform, as: "perform"
  end

  controller :sessions do
    get "login" => :new
    post "login" => :create
    get "logout" => :destroy
  end

  resources :settings, except: [ :new, :edit ]

  controller :static_pages do
    get "favicon.ico" => :favicon         # temporary fix, remove when favicon is made
    root to: :root
  end
end
