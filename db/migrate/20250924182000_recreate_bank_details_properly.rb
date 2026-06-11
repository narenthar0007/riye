class RecreateBankDetailsProperly < ActiveRecord::Migration[8.0]
  def up
    # Drop the table if it exists
    drop_table :bank_details if table_exists?(:bank_details)
    
    # Create the table with proper indexes
    create_table :bank_details do |t|
      t.references :worker, null: false, foreign_key: true, index: { unique: true }
      t.string :name_of_beneficiary, null: false
      t.string :account_number, null: false
      t.string :bank_name, null: false
      t.string :ifsc_code, null: false
      t.string :branch_name, null: false
      t.timestamps
    end

    # Add additional indexes
    add_index :bank_details, :account_number, unique: true
    add_index :bank_details, :ifsc_code
  end

  def down
    drop_table :bank_details if table_exists?(:bank_details)
  end
end
