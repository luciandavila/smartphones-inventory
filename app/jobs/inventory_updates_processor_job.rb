# frozen_string_literal: true

require 'csv'

class InventoryUpdatesProcessorJob < ApplicationJob
  class InvalidCsv < StandardError; end
  private_constant :InvalidCsv

  attr_reader :inventory_update

  queue_as :default

  # retries will be done only through interface
  discard_on(StandardError)
  rescue_from(StandardError) { |exception| handle exception }

  def perform(model)
    @inventory_update = model

    # this will perform a full table replacement
    ActiveRecord::Base.transaction do
      Smartphone.delete_all

      process_csv_file

      inventory_update.update! status: 'completed'
    end
  end

  def process_csv_file
    file_path = ActiveStorage::Blob.service.send(:path_for, inventory_update.csv_file.key)

    CSV.foreach file_path, headers: true do |row|
      validate! row

      Smartphone.create! row.to_h
    end
  end

  def validate!(row)
    hash = row.to_h

    %w[manufacturer model color carrier_plan_type quantity price].each do |key|
      raise InvalidCsv if !hash.key?(key) || hash[key].blank?
    end
  end

  def handle(exception)
    processing_error = exception.instance_of?(InvalidCsv) ? 'invalid_csv' : 'unexpected_error'

    inventory_update.update! status: 'completed', processing_error: processing_error
  end
end
