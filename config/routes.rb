Zipifieds::Application.routes.draw do
  get 'messages/index'

  get 'conversations/index'

  root :to => "home#index"
  #devise_for :users, controllers: { registrations: "registrations" }
  devise_for :users, controllers: {registrations: "registrations", omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, :ads, :conversations, :messages

  #get "/callback" => "facebook#callback"
  #get "/facebook_profile" => "facebook#facebook_profile"

end
