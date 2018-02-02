PostitTemplate::Application.routes.draw do
  root to: "posts#index"
  
  # the route, then route it to the posts controller, index action
  get "/register", to: "users#new"
  
  # These resources simulate logging in / out
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  
  # show is defined as a method inside the posts_controller.rb file
  # You can determine the name of the :id part & use that in your ruby code
  # under the `params` variable
  # get "/posts/:id", to: "posts#show"
  # get "/posts/new", to:"posts#new"
  # post "/posts", to: "posts#create"
  # get "/posts/:id/edit", to: "posts#edit"
  # patch "/posts/:id", to: "posts#update"
  resources :posts, except: [:destroy] do
    member do
      post :vote # builds out "posts/:id/vote" for every posts/:id
    end
    
    # collection do
    #   get :archives # "/posts/archives"
    # end
    resources :comments, only: [:create] do
      member do
        post :vote # "posts/:id/comments/:id/vote"
      end
    end
  end
  resources :categories, only: [:new, :create, :show]
  resources :users, except: [:destroy, :new]
end
