# frozen_string_literal: true

FactoryBot.define do
  factory :smartphone do
    manufacturer { 'Motorola' }
    model { 'Moto G6 Plus' }
    color { 'Indigo' }
    carrier_plan_type { 'pos' }
    quantity { 10 }
    price { 1000 }
  end
end
