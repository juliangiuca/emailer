Emailer::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get 'sign_in', :to => 'users/sessions#new', :as => :new_session
    get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_session
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get 'welcome', to: 'welcome#index'
  root "emails#index"

  get     'ngViews/*url',  to: 'ng_views#get'
  put     'ngViews/*url',  to: 'ng_views#put'
  delete  'ngViews/*url',  to: 'ng_viesw#delete'
  post    'ngViews/*url',  to: 'ng_views#post'


  get "/emails",     to: "emails#index"
  get "/contacts",   to: "contacts#index"
  get "/groups",     to: "groups#index"

  namespace "api" do
    namespace "v1" do
      resources :contacts

      resources :emails do
        resources :recipients
      end

      post '/emails/:id/deliver', to: "emails#deliver", as: "email_deliver"

      resources :groups do
        resources :members do
          post 'bulk', on: :collection
        end
      end
    end
  end
end
