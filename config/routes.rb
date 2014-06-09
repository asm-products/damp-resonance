Zipifieds::Application.routes.draw do
  resources :categories

  get 'messages/index'

  get 'conversations/index'
  get 'ads/myindex'

  root :to => "home#index"
  devise_for :users, controllers: {registrations: "registrations", omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, :ads

  resources :messages do
  member do
    post :new
  end
end
resources :conversations do
  member do
    post :reply
    post :trash
    post :untrash
  end
 collection do
    get :trashbin
    post :empty_trash
 end
end


end
