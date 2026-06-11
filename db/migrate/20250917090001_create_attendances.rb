class CreateAttendances < ActiveRecord::Migration[8.0]
  def change
    create_table :attendances do |t|
      t.datetime :punch_in
      t.datetime :punch_out
      t.references :worker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
