Rails.application.routes.draw do
  root 'cover_letters#new'
  
  resources :cover_letters, only: [:new, :create, :show] do
    member do
      get :result
    end
  end
  
  get "up" => "rails/health#show", as: :rails_health_check
end
