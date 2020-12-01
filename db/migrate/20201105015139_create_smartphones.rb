class CreateSmartphones < ActiveRecord::Migration[6.0]
  def change
    create_table :smartphones do |t|
      t.string :manufacturer, index: true
      t.string :model, index: true
      t.string :color
      t.string :carrier_plan_type, index: true
      t.integer :quantity
      t.float :price

      t.timestamps
    end
  end
end
