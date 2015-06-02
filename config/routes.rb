Cenit::Application.routes.draw do
  mount RailsAdmin::Engine => '/data', as: 'rails_admin'

  root to: 'rails_admin/main#dashboard'
  # root to: 'home#index'

  get 'schema', to: 'schema#index'
  get '/file/:model/:field/:id/:file', to: 'file#index'

  get 'explore/:api', to: 'api#explore', as: :explore_api
  post 'write/:api', to: 'api#write', as: :write_api

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"} do
    get 'sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end

  namespace :api do
    namespace :v1 do
      post '/push', to: 'api#push'
      get '/:model', to: 'api#index'
      get '/:model/:id', to: 'api#show'
      delete '/:model/:id', to: 'api#destroy'
      post '/auth', to: 'api#auth'
    end
  end
end
