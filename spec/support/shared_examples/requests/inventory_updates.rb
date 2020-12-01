# frozen_string_literal: true

RSpec.shared_examples 'redirect to index action' do
  it 'redirects to index action' do
    subject

    expect(last_response.status).to eq(302)
    expect(last_response.location).to match '/inventory_updates'
  end
end
