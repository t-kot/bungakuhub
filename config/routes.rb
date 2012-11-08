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
  resources :repositories, only: [:new]
  resources :text_repositories, only: [:new, :create]
  resources :users, except: [:index, :new, :create] do
    resources :repositories, only: [:index, :show] do
      resources :branches, only: [:index, :show] do
        resources :kommits, only: [:index, :show]
      end
    end
    resources :text_repositories, only: [:index, :show]
    namespace :admin do
      resources :text_repositories, except: [:create, :new, :destroy]
      resources :repositories, only: [:index, :show, :edit, :update, :destroy] do
        resources :branches, only: [:show, :new, :create, :destroy] do
          resources :kommits, only: [:index, :show, :new, :create, :destroy]
        end
      end
    end
  end

  root to: "home#index"
end
