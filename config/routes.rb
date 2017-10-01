Rails.application.routes.draw do
  resources :wikis
  resources :charges, only: [:new, :create]
  resources :downgrade, only: [:new, :create]

  devise_for :users, :controllers => { sessions: 'sessions', registrations: 'registrations'}


  get 'about' => 'welcome#about'

  root 'welcome#index'
  post 'downgrade/create'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
