PostitTemplate::Application.routes.draw do
  root to: "posts#index"
  
  # the route, then route it to the posts controller, index action
  get "/posts", to: "posts#index"
  
  # show is defined as a method inside the posts_controller.rb file
  # You can determine the name of the :id part & use that in your ruby code
  # under the `params` variable
  # get "/posts/:id", to: "posts#show"
  # get "/posts/new", to:"posts#new"
  # post "/posts", to: "posts#create"
  # get "/posts/:id/edit", to: "posts#edit"
  # patch "/posts/:id", to: "posts#update"
  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end
  
end
