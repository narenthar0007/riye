class CreateTeamHeads < ActiveRecord::Migration[8.0]
  def change
    create_table :team_heads do |t|
      t.string :name, null: false
      t.date :dob
      t.integer :age
      t.string :gender
      t.text :address
      t.string :aadhaar_number
      t.string :contact_number
      t.timestamps
    end

    add_index :team_heads, :aadhaar_number, unique: true
    add_index :team_heads, :contact_number
  end
end
