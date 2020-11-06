# frozen_string_literal: true

class InventoryUpdate < ApplicationRecord
  validates :status, presence: true
  validates_inclusion_of :status, in: %w[processing completed]

  has_one_attached :csv_file

  validate :csv_file_validation

  def csv_file_validation
    return if csv_file.attached?

    errors[:csv_file] << 'Has to be attached'
  end
end
