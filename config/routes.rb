Bungaku::Application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "/users/sign_in", to: 'devise/sessions#new', as: :new_user_session
    get "/users/sign_out", to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  scope module: :home do
    resources :repositories, only: [:index]
    resources :text_repositories, only: [:index]
  end
  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :repositories, only: [:index]
    resources :text_repositories, only: [:index, :new, :create]
  end
  resources :text_repositories, only: [:show]
  resources :repositories, only: [:show, :new] do
    resources :branches, only: [:index]
  end
  resources :branches, only: [:show] do
    resources :kommits, only: [:index, :show]
  end

  namespace :admin do
    resources :text_repositories, only: [:index, :show, :edit, :update]
    resources :repositories, only: [:index, :show, :edit, :update, :destroy] do
      resources :branches, only: [:new, :create]
    end
    resources :branches, only: [:show, :destroy] do
      resources :kommits, only: [:index, :show, :new, :create, :destroy] do
        resource :revert, only: [:create]
      end
    end
  end
  root to: "home#index"
end
