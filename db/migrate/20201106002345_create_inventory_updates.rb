class CreateInventoryUpdates < ActiveRecord::Migration[6.0]
  def change
    create_table :inventory_updates do |t|
      t.string :status
      t.string :processing_error

      t.timestamps
    end
  end
end
