class AddProjectIdToStocks < ActiveRecord::Migration[7.0]
  def change
    add_column :stocks, :project_id, :integer
    add_index :stocks, :project_id
    add_foreign_key :stocks, :projects
  end
end
