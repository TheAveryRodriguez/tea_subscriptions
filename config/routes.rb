Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      post "/customers/:customer_id/subscriptions/:subscription_id", to: "customer_subscriptions#create"
      patch "/customers/:customer_id/subscriptions/:subscription_id", to: "customer_subscriptions#update"
      get "/customers/:customer_id/subscriptions", to: "customer_subscriptions#index"
    end
  end
end
