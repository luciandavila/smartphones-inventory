# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Smartphones', type: :request do
  describe 'GET /smartphones' do
    it 'returns http success' do
      get '/smartphones'
      expect(response).to have_http_status(:success)
    end
  end
end
