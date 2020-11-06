# frozen_string_literal: true

class SmartphonesController < ApplicationController
  def index
    @manufacturers = Smartphone.all_manufacturers
    @models = Smartphone.all_models
    @carrier_plan_types = Smartphone.all_carrier_plan_types

    @selected_manufacturer = filters[:manufacturer]
    @selected_model = filters[:model]
    @selected_carrier_plan_type = filters[:carrier_plan_type]

    @smartphones = Smartphone.where(filters).order(created_at: :desc)
  end

  def filters
    @filters ||= params.permit(permitted_params).reject { |_key, value| value.blank? }
  end

  def permitted_params
    %i[manufacturer model carrier_plan_type]
  end
end
