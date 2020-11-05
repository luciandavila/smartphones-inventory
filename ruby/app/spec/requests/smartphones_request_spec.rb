# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Smartphones', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/smartphones/index'
      expect(response).to have_http_status(:success)
    end
  end
end
