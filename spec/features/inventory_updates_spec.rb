# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Inventory Updates features', type: :feature do
  describe 'inventory updates list' do
    context 'when there is a processing update' do
      let!(:inventory_update) { create :inventory_update, status: 'processing' }

      it 'is displayed accordingly' do
        visit '/inventory_updates'

        expect(page).to have_content('Em processamento...')
        expect(page).to have_content('atualizar a página')
      end
    end

    context 'when there is a completed update' do
      let!(:inventory_update) { create :inventory_update, status: 'completed' }

      it 'is displayed accordingly' do
        visit '/inventory_updates'

        expect(page).to have_content('Processamento concluido.')
      end

      context 'when the completed update has an unexpected processing error' do
        let!(:inventory_update) { create :inventory_update, status: 'completed', processing_error: 'unexpected_error' }

        it 'is displayed accordingly' do
          visit '/inventory_updates'

          expect(page).to have_content('Erro.')
          expect(page).to have_content('Retentar processamento.')
        end
      end

      context 'when the completed update has an csv_invalid processing error' do
        let!(:inventory_update) { create :inventory_update, status: 'completed', processing_error: 'invalid_csv' }

        it 'is displayed accordingly' do
          visit '/inventory_updates'

          expect(page).to have_content('Erro.')
          expect(page).not_to have_content('Retentar processamento.')
        end
      end
    end
  end
end
