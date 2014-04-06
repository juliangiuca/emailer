Emailer::Application.routes.draw do
  devise_for :users

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
    post 'deliver'
  end

  resources :groups do
    resources :members
  end

end
