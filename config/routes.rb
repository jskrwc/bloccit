Rails.application.routes.draw do


  # resources :topics
  # resources :posts

  resources :topics do
    # nests post routes under the topics routes
    resources :posts, except: [:index]
  end

  resources :posts, only: [] do
  # comments will be on posts show view, so don't need index or new routes
  # don't need show, update or edit routes bc we won't let users view indivd comments
      resources :comments, only: [:create, :destroy]
  end


  # nb only prevents rails from creating unnecessary routes
  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  # get 'welcome/index'
  # get 'welcome/about'

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
