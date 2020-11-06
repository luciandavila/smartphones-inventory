# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'InventoryUpdates', type: :request do
  describe 'GET /index' do
    before { InventoryUpdate.destroy_all }

    it 'returns http success' do
      get '/inventory_update/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    include Rack::Test::Methods
    include ActionDispatch::TestProcess

    let(:params) { { csv_file: Rack::Test::UploadedFile.new('spec/files/input_valid.csv', 'text/csv', true) } }

    subject { post '/inventory_update/create', params }

    it 'redirects to index action' do
      subject

      expect(last_response.status).to eq(302)
      expect(last_response.location).to match 'inventory_update/index'
    end

    it 'creates an inventory update' do
      expect { subject }.to change(InventoryUpdate, :count).by(1)

      expect(InventoryUpdate.last.status).to eq 'processing'
      expect(InventoryUpdate.last.csv_file.attached?).to be_truthy
    end

    # rubocop:disable Lint/EmptyBlock
    xit 'enqueues job to proccess inventory update' do
    end
    # rubocop:enable Lint/EmptyBlock
  end
end
