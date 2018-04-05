Rails.application.routes.draw do


  # resources :topics
  # resources :posts

  resources :topics do
    # nests post routes under the topics routes
    resources :posts, except: [:index]
  end

  # nb only prevents rails from creating unnecessary routes
  resources :users, only: [:new, :create]
  post 'users/confirm' => 'users#confirm'


  get 'about' => 'welcome#about'

  root 'welcome#index'
end
