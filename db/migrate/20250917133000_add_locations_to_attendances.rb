class AddLocationsToAttendances < ActiveRecord::Migration[7.0]
  def change
    add_column :attendances, :punch_in_location, :string
    add_column :attendances, :punch_out_location, :string
  end
end
