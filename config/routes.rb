Bungaku::Application.routes.draw do



  devise_for :users
  devise_scope :user do
    get "/users/sign_in", to: 'devise/sessions#new', as: :new_user_session
    get "/users/sign_out", to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :users, except: [:new,:create] do
    resources :repositories
    resources :text_repositories
  end
  namespace :users do
    resources :admin, as: :user do
      resources :repositories
      resources :text_repositories
    end
  end

  root to: "home#index"
end
