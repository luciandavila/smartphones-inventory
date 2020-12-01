# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples/requests/inventory_updates'

RSpec.describe 'InventoryUpdates', type: :request do
  describe 'GET /inventory_updates' do
    subject { get '/inventory_updates' }
    it 'returns http success' do
      subject
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /inventory_updates' do
    include Rack::Test::Methods

    let!(:another_inventory_update) { create :inventory_update }
    let(:params) { { csv_file: Rack::Test::UploadedFile.new('spec/files/input_valid.csv', 'text/csv') } }

    subject { post '/inventory_updates', params }

    it_behaves_like 'redirect to index action'

    it 'creates an inventory update' do
      expect { subject }.to change(InventoryUpdate, :count).by(1)

      expect(InventoryUpdate.last.status).to eq 'processing'
      expect(InventoryUpdate.last.csv_file.attached?).to be_truthy
    end

    it 'enqueues job to proccess inventory update' do
      expect(InventoryUpdatesProcessorJob).to receive(:perform_later) do |inventory_update|
        expect(inventory_update.id).to eq(another_inventory_update.id + 1)
      end

      subject
    end
  end

  describe 'PUT /inventory_updates/:id/retry' do
    include Rack::Test::Methods

    subject { put "/inventory_updates/#{inventory_update.id}/retry" }

    context 'when inventory update was completed with unknown processing error' do
      let!(:inventory_update) { create :inventory_update, status: 'completed', processing_error: 'unexpected_error' }

      it_behaves_like 'redirect to index action'

      it 'enqueues job to proccess inventory update' do
        expect(InventoryUpdatesProcessorJob).to receive(:perform_later) do |inventory_update|
          expect(inventory_update.id).to eq(inventory_update.id)
        end

        subject
        inventory_update.reload

        expect(inventory_update.status).to eq 'processing'
        expect(inventory_update.processing_error).to eq nil
      end
    end

    context 'when the inventory update was completed with no errors' do
      let!(:inventory_update) { create :inventory_update, status: 'completed' }

      it_behaves_like 'redirect to index action'

      it { expect(InventoryUpdatesProcessorJob).not_to receive(:perform_later) }
    end

    context 'when the inventory update was completed with invalid_csv processing error' do
      let!(:inventory_update) { create :inventory_update, status: 'completed', processing_error: 'invalid_csv' }

      it_behaves_like 'redirect to index action'

      it { expect(InventoryUpdatesProcessorJob).not_to receive(:perform_later) }
    end
  end
end
