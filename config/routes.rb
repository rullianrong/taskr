Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'tasks#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  
  resources :tasks
  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
