# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Smartphones features', type: :feature do
  describe 'Smartphones list' do
    let!(:smartphone) { create :smartphone, carrier_plan_type: 'pre' }
    let!(:smartphone_2) { create :smartphone, manufacturer: 'Apple' }
    let!(:smartphone_3) { create :smartphone, model: 'Galaxy' }

    let(:table) { find(:css, 'table') }

    it 'filters inventory correctly' do
      visit '/smartphones?carrier_plan_type=pre'

      expect(table).to have_content('Pré pago', count: 1)
      expect(table).not_to have_content('Apple')
      expect(table).not_to have_content('Galaxy')

      visit '/smartphones?manufacturer=Apple'

      expect(table).not_to have_content('Pré pago')
      expect(table).to have_content('Apple', count: 1)
      expect(table).not_to have_content('Galaxy')

      visit '/smartphones?model=Galaxy'

      expect(table).not_to have_content('Pré pago')
      expect(table).not_to have_content('Apple')
      expect(table).to have_content('Galaxy', count: 1)
    end

    context 'when no filters are applied' do
      it 'shows all smartphones' do
        visit '/smartphones'

        expect(table).to have_content('Pré pago', count: 1)
        expect(table).to have_content('Apple', count: 1)
        expect(table).to have_content('Galaxy', count: 1)
      end
    end
  end
end
