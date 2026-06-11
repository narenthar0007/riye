class AddUniqueIndexToWorkersContact < ActiveRecord::Migration[7.0]
  def change
    add_index :workers, :contact, unique: true
  end
end
