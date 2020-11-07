# frozen_string_literal: true

class InventoryUpdateController < ApplicationController
  def index
    @inventory_updates = InventoryUpdate.all.order created_at: :desc
  end

  def create
    resource = InventoryUpdate.new status: 'processing'
    resource.csv_file.attach params[:csv_file]
    resource.save!

    InventoryUpdatesProcessorJob.perform_later resource
    redirect_to inventory_update_index_path
  end
end
