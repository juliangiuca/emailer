Emailer::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  #devise_scope :user do
    #get 'sign_in', :to => 'users/omniauth_callbacks#passthru', :as => :new_user_session, default: {provider: "google_oauth2"}
    #get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  #end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  get     'ngViews/*url',  to: 'ng_views#get'
  put     'ngViews/*url',  to: 'ng_views#put'
  delete  'ngViews/*url',  to: 'ng_viesw#delete'
  post    'ngViews/*url',  to: 'ng_views#post'

  get '/auth/:provider/callback', to: 'auth#create'

  resources :contacts

  resources :emails do
    resources :recipients
  end

  resources :groups do
    resources :members
  end

end
