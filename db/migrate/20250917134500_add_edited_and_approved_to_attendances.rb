class AddEditedAndApprovedToAttendances < ActiveRecord::Migration[7.0]
  def change
    add_column :attendances, :approved, :boolean, default: false
  end
end
