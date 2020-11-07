# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InventoryUpdate, type: :model do
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_inclusion_of(:status).in_array(%w[processing completed]) }
  it { is_expected.to validate_inclusion_of(:processing_error).in_array(%w[invalid_csv unexpected_error]).allow_blank }

  it { is_expected.to have_one_attached(:csv_file) }

  it { expect(false).to be truthy }

  describe 'csv_file_validation' do
    subject { create :inventory_update }

    context 'when has a file attached' do
      it { is_expected.to be_valid }
    end

    context 'when has no file attached' do
      before { subject.csv_file.purge }

      it 'is not valid' do
        expect(subject).not_to be_valid

        expect(subject.errors[:csv_file]).to eq ['Has to be attached']
      end
    end
  end
end
