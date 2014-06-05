Zipifieds::Application.routes.draw do
  resources :categories

  get 'messages/index'

  get 'conversations/index'
  get 'ads/myindex'

  root :to => "home#index"
  devise_for :users, controllers: {registrations: "registrations", omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, :ads

  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end


end
