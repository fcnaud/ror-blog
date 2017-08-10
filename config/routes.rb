Rails.application.routes.draw do

  root 'welcome#index'
  get 'show-style' => 'welcome#show'
  post 'markdown' => 'welcome#get_markdown'

  resources :posts do
    resources :comments
  end

  resources :users do 
    member do
      get :comments
      get :posts
      get :follower
      get :following
      post :follow
      post :unfollow
    end
  end
  resources :sessions

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
