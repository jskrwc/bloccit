Rails.application.routes.draw do
  get 'questions/index'

  get 'questions/show'

  get 'questions/new'

  get 'questions/edit'

  # get 'posts/index'
  # get 'posts/show'
  # get 'posts/new'
  # get 'posts/edit'

  resources :posts

  # get 'welcome/index'
  # get 'welcome/about'

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
