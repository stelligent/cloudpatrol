CloudpatrolRails::Application.routes.draw do
  controller :tasks, path: "tasks" do
    get "" => :index, as: "tasks"
    get "perform" => :perform, as: "perform_task"
  end

  controller :sessions do
    get "login" => :new
    post "login" => :create
    get "logout" => :destroy
  end

  resources :settings

  controller :static_pages do
    get "favicon.ico" => :favicon         # temporary fix, remove when favicon is made
    root to: :root
  end
end
