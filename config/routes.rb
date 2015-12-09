Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#router'

  get "/email_confirmation_required" => 'pages#email_confirm_required', as: :email_confirm_required
  get "/home" => 'home#index', as: :home

  resources :students,  only: [:index, :create]
  resources :teams do
    member do
      post  :request_join
      post  :leave
      post  :complete
      post  :incomplete
      get   :add_student
      post  :add_student
      post  :remove_student
      post  :set_as_liaison
      post  :accept_request
    end
  end
  resource :account,    only: [:show, :update]
  resources :courses do
    member do
      post :register
      post :unregister
    end
  end
end
