Zipifieds::Application.routes.draw do
  
  get "/callback" => "facebook#callback"
  get "/facebook_profile" => "facebook#facebook_profile"
  
  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  get 'ads/myindex'
  get 'ads/iscroll'
  get 'test/getJobs'

  root :to => "ads#index"
  devise_for :users, controllers: {registrations: "registrations", omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, :ads, :messages, :categories, :conversations, :messages, :facebook

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
