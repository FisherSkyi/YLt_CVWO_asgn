Rails.application.routes.draw do
  get "tags/index"
  get "tags/show"
  get "tags/create"
  get "comments/create"
  get "comments/destroy"
  get "users/show"
  get "users/index"
  get "posts/index"
  get "posts/show"
  get "posts/new"
  get "posts/create"
  get "posts/edit"
  get "posts/update"
  get "posts/destroy"
  # Home page redirects to the posts index
  root "posts#index"

  # User routes
  resources :users, only: [:show, :index]

  # Post routes (with nested comments)
  resources :posts do
    resources :comments, only: [:create, :destroy] # Comments nested under posts
    resources :tags, only: [:index, :create], shallow: true # Tags nested under posts
  end

  # Tag routes (view posts by a specific tag)
  resources :tags, only: [:index, :show]

  # Additional optional routes (for example, a health check)
  get "health", to: "application#health"

end
