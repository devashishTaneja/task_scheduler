Rails.application.routes.draw do
  # UsersController
  root to:'users#index'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'user/show/:id', to: 'users#show', as: 'show_user'
  delete 'user/delete/:id', to: 'users#delete', as: 'delete_user'
end
