Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :v1 do
    resource :users, only: [:create]
    post 'login', to: 'sessions#auth'
  end
end
