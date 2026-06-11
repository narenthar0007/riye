class CreateDailyUpdates < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_updates do |t|
      t.text :note
      t.references :user, null: false, foreign_key: true
      t.boolean :approved, default: false
      t.timestamps
    end
  end
end
