class AddDatesToProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :start_date, :date
    add_column :projects, :end_date, :date
  end
end
