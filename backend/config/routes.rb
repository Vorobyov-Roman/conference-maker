Rails.application.routes.draw do

  # authentication
  post "/register", to: "auth#register"
  post "/login",    to: "auth#login"

  # resources
  resources "applications", only: [:index, :show]
  resources "conferences",  only: [:index, :show, :create]
  resources "reviews",      only: [:index, :show]
  resources "topics",       only: [:index, :show]
  resources "users",        only: [:index, :show]

  # validation
  scope "/validate" do
    post "/application", to: "validation#application"
    post "/conference",  to: "validation#conference"
    post "/review",      to: "validation#review"
    post "/topic",       to: "validation#topic"
    post "/user",        to: "validation#user"
  end

  # default
  match "*path", "/", to: "application#default", via: :all

end
