class CreateWorkers < ActiveRecord::Migration[8.0]
  def change
    create_table :workers do |t|
      t.string :name
      t.string :contact
      t.references :project, null: false, foreign_key: true
      t.integer :head_worker_id

      t.timestamps
    end
  end
end
