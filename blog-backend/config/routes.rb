Rails.application.routes.draw do
  get 'users/show'

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end

  namespace :api do
    namespace :v2 do
      resources :blogs do
        resources :comments
      end
      get "getchart", controller: :blogs, action: :getChart

    end
  end

  root to: "home#index"

  post "refresh", controller: :refresh, action: :create
  post "signin", controller: :signin, action: :create
  post "signup", controller: :signup, action: :create
  delete "signin", controller: :signin, action: :destroy
end
