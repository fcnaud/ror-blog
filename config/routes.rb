Rails.application.routes.draw do

  root 'welcome#index'
  get 'show-style' => 'welcome#show'
  post 'markdown' => 'welcome#get_markdown'

  resources :posts do
    member do 
      get :edit_tag
      get :add_tag
      get :delete_tag
    end
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

  resources :tags, only: [:index, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
