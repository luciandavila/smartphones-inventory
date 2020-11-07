# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples/jobs/inventory_updates_processor'

RSpec.describe InventoryUpdatesProcessorJob, type: :job do
  subject { described_class.perform_now inventory_update }

  context 'when a valid inventory update is processed' do
    let!(:inventory_update) { create :inventory_update }
    let!(:smartphone) { create :smartphone }

    let(:expected_last_row) do
      {
        manufacturer: 'Apple', model: 'iPhone SE 16GB', color: 'Rose',
        carrier_plan_type: 'pre', quantity: 5, price: 1499
      }
    end

    it_behaves_like 'update inventory_update model', status: { before: 'processing', after: 'completed' },
                                                     processing_error: { before: nil, after: nil }

    it 'replaces the table entirely' do
      expect { subject }.to change(Smartphone, :count).from(1).to(12)
      expect(Smartphone.exists?(smartphone.id)).to eq false
      expect(Smartphone.last.attributes).to include expected_last_row.stringify_keys
    end
  end

  context 'when an invalid inventory update is processed' do
    let(:inventory_update) do
      create :inventory_update, csv_file: Rack::Test::UploadedFile.new('spec/files/input_invalid.csv', 'text/csv')
    end

    it_behaves_like 'update inventory_update model', status: { before: 'processing', after: 'completed' },
                                                     processing_error: { before: nil, after: 'invalid_csv' }
  end

  context 'when a unexpected error happens' do
    before { allow(Smartphone).to receive(:delete_all).and_raise(StandardError) }

    let!(:inventory_update) { create :inventory_update }

    it_behaves_like 'update inventory_update model', status: { before: 'processing', after: 'completed' },
                                                     processing_error: { before: nil, after: 'unexpected_error' }
  end
end
