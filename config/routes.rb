Rails.application.routes.draw do

  # 
  # get 'sponsored_posts/show'
  #
  # get 'sponsored_posts/new'
  #
  # get 'sponsored_posts/edit'

  # resources :topics
  # resources :posts

  resources :topics do
    # nests post routes under the topics routes
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end

  # get 'welcome/index'
  # get 'welcome/about'

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
