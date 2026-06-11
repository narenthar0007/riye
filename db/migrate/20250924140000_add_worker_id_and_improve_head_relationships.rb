class AddWorkerIdAndImproveHeadRelationships < ActiveRecord::Migration[8.0]
  def up
    # Add custom worker_id field (nullable first, then make it NOT NULL after populating)
    add_column :workers, :worker_id, :string, null: true
    
    # Add foreign key constraint for head_worker_id
    add_foreign_key :workers, :workers, column: :head_worker_id, name: 'fk_workers_head_worker'
    add_index :workers, :head_worker_id

    # Generate worker_ids starting from 1000 for existing workers using raw SQL
    workers = connection.select_all("SELECT id FROM workers ORDER BY id")
    workers.each_with_index do |worker, index|
      worker_id = "W#{1000 + index}"
      connection.execute("UPDATE workers SET worker_id = #{connection.quote(worker_id)} WHERE id = #{worker['id']}")
    end

    # Now make worker_id NOT NULL and add unique index
    change_column_null :workers, :worker_id, false
    add_index :workers, :worker_id, unique: true
  end

  def down
    remove_foreign_key :workers, name: 'fk_workers_head_worker'
    remove_index :workers, :head_worker_id
    remove_index :workers, :worker_id
    remove_column :workers, :worker_id
  end
end
