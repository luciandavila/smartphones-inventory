# frozen_string_literal: true

class InventoryUpdate < ApplicationRecord
  validates :status, presence: true
  validates_inclusion_of :status, in: %w[processing completed]
  validates_inclusion_of :processing_error, in: %w[invalid_csv unexpected_error], allow_blank: true

  has_one_attached :csv_file

  validate :csv_file_validation

  def csv_file_validation
    return if csv_file.attached?

    errors[:csv_file] << 'Has to be attached'
  end
end
