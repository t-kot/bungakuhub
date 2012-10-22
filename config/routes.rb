Bungaku::Application.routes.draw do



  devise_for :users
  devise_scope :user do
    get "/users/sign_in", to: 'devise/sessions#new', as: :new_user_session
    get "/users/sign_out", to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :repositories, only: [:index, :new]
  resources :text_repositories, except: [:edit, :show, :update, :destroy]
  resources :users, except: [:index, :new, :create] do
    scope module: :users do
      resources :text_repositories, except: [:create, :new, :destroy]
      resources :repositories, except: [:create, :new]
    end
  end

  root to: "home#index"
end
