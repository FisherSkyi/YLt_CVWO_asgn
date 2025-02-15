Rails.application.routes.draw do

  # Home page redirects to the posts index
  root "posts#index"

  resource :session, only: [:new, :create, :destroy]

  # User routes
  resources :users, only: [:new, :create, :show, :index]

  # Post routes (with nested comments)
  resources :posts do
    resources :comments, only: [:create, :destroy] # Comments nested under posts
    # resources :tags, only: [:index, :create], shallow: true # Tags nested under posts
  end

  # Tag routes (view posts by a specific tag)
  resources :tags, only: [:index, :show]

  # Additional optional routes (for example, a health check)
  get "health", to: "application#health"

end
