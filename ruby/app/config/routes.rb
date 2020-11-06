Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'smartphones/index'
  get 'inventory_update/index'
  post 'inventory_update/create'

  root to: 'inventory_update#index'
end
