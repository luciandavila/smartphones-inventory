# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'smartphones', to: 'smartphones#index'
  get 'inventory_updates', to: 'inventory_updates#index'
  post 'inventory_updates', to: 'inventory_updates#create'

  root to: 'inventory_update#index'
end
