class CreateApiAccesses < ActiveRecord::Migration[8.0]
  def change
    create_table :api_accesses do |t|
      t.string :access_key, null: false
      t.string :secret_key
      t.string :name
      t.text :permissions
      t.references :user, foreign_key: true, null: true
      t.datetime :last_used_at
      t.datetime :expires_at
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :api_accesses, :access_key, unique: true
  end
end