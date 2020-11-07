# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'smartphones', to: 'smartphones#index'
  get 'inventory_updates', to: 'inventory_updates#index'
  post 'inventory_updates', to: 'inventory_updates#create'
  put 'inventory_updates/:id/retry', to: 'inventory_updates#retry', as: 'inventory_update_retry'

  root to: 'inventory_updates#index'
end
