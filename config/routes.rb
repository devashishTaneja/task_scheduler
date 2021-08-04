Rails.application.routes.draw do
  # UsersController
  root to:'users#index'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'user/show/:id', to: 'users#show', as: 'show_user'
  delete 'user/delete/:id', to: 'users#delete', as: 'delete_user'


  # TasksController
  get 'new_task', to: 'tasks#new'
  post 'new_task', to: 'tasks#create'
  post 'task/update/:id', to: 'tasks#update', as: 'update_task'
  get 'task/show/:id', to: 'tasks#show', as: 'show_task'
  get 'task/edit/:id', to: 'tasks#edit', as: 'edit_task'
  delete 'task/delete/:id', to: 'tasks#delete', as: 'delete_task'

end
