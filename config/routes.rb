Zipifieds::Application.routes.draw do
  get 'messages/index'

  get 'conversations/index'

  root :to => "home#index"
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, :ads, :conversations, :messages, :facebook
 
  get "/callback" => "facebook#callback"
  get "/facebook_profile" => "facebook#facebook_profile"

end
