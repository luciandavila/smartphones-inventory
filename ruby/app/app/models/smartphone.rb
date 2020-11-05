# frozen_string_literal: true

class Smartphone < ApplicationRecord
  CARRIER_PLAN_TYPES = %w[pre pos].freeze

  validates :manufacturer, :model, :color, :carrier_plan_type, :quantity, :price, presence: true
  validates_inclusion_of :carrier_plan_type, in: CARRIER_PLAN_TYPES

  def self.all_manufacturers
    find_by_sql('SELECT manufacturer FROM smartphones GROUP BY manufacturer').pluck :manufacturer
  end

  def self.all_models
    find_by_sql('SELECT model FROM smartphones GROUP BY model').pluck :model
  end

  def self.all_carrier_plan_types
    CARRIER_PLAN_TYPES
  end
end
