# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Smartphone, type: :model do
  it { is_expected.to validate_presence_of(:manufacturer) }
  it { is_expected.to validate_presence_of(:model) }
  it { is_expected.to validate_presence_of(:color) }
  it { is_expected.to validate_presence_of(:carrier_plan_type) }
  it { is_expected.to validate_presence_of(:quantity) }
  it { is_expected.to validate_presence_of(:price) }

  it { is_expected.to validate_inclusion_of(:carrier_plan_type).in_array(%w[pre pos]) }

  describe 'self.all_models' do
    let!(:phone_1) { create :smartphone }
    let!(:phone_2) { create :smartphone, model: 'Moto G7 Plus' }
    let!(:phone_3) { create :smartphone }

    subject { described_class.all_models }

    it 'returns all models with no duplicates' do
      expect(subject.size).to eq 2
      expect(subject).to include(phone_1.model, phone_2.model)
    end
  end

  describe 'self.all_manufacturers' do
    let!(:phone_1) { create :smartphone }
    let!(:phone_2) { create :smartphone, manufacturer: 'Apple' }
    let!(:phone_3) { create :smartphone }

    subject { described_class.all_manufacturers }

    it 'returns all manufactures with no duplicates' do
      expect(subject.size).to eq 2
      expect(subject).to include(phone_1.manufacturer, phone_2.manufacturer)
    end
  end

  describe 'self.all_carrier_plan_types' do
    subject { described_class.all_carrier_plan_types }

    it 'returns all possible carrier_plan_types' do
      expect(subject).to eq %w[pre pos]
    end
  end
end
