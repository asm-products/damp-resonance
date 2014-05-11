Zipifieds::Application.routes.draw do
  get 'messages/index'

  get 'conversations/index'

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users, :ads
   
  resources :conversations 
  resources :messages
   
end
