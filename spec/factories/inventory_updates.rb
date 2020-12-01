# frozen_string_literal: true

FactoryBot.define do
  factory :inventory_update do
    status { 'processing' }
    processing_error { nil }
    csv_file { Rack::Test::UploadedFile.new('spec/files/input_valid.csv', 'text/csv') }
  end
end
