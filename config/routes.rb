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
  resources :categories do
    get '/tasks/new', to: 'tasks#new_categorized_task'
    post '/tasks', to: 'tasks#create_categorized_task'
  end
end
