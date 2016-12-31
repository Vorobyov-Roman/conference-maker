Rails.application.routes.draw do

  post "/register", to: "auth#register"
  post "/login",    to: "auth#login"

  scope "/validate" do
    post "/user", to: "validation#user"
  end

  match "*path", "/", to: "application#default", via: :all

end
