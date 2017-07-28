Rails.application.routes.draw do

  root 'welcome#index'
  get 'show-style' => 'welcome#show'

  resources :posts do
    resources :comments
  end

  resources :users
  resources :sessions

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
