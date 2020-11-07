# frozen_string_literal: true

RSpec.shared_examples 'update inventory_update model' do |attributes|
  # rubocop:disable Layout/LineLength
  it "changes inventory update status from #{attributes[:status][:before] || 'nil'} to #{attributes[:status][:after] || 'nil'}" do
    expect(inventory_update.status).to eq attributes[:status][:before]

    subject
    inventory_update.reload

    expect(inventory_update.status).to eq attributes[:status][:after]
  end

  it "changes inventory update processing_error from #{attributes[:processing_error][:before] || 'nil'} to #{attributes[:processing_error][:after] || 'nil'}" do
    expect(inventory_update.processing_error).to eq attributes[:processing_error][:before]

    subject
    inventory_update.reload

    expect(inventory_update.processing_error).to eq attributes[:processing_error][:after]
  end
  # rubocop:enable Layout/LineLength
end
