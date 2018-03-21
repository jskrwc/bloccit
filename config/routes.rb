Rails.application.routes.draw do


  # resources :topics
  # resources :posts

  resources :topics do
    # nests post routes under the topics routes
    resources :posts, except: [:index]
  end

  # get 'welcome/index'
  # get 'welcome/about'

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
