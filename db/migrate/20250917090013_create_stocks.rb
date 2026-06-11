class CreateStocks < ActiveRecord::Migration[8.0]
  def change
    create_table :stocks do |t|
      t.string :name
      t.integer :quantity
      t.string :unit
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
