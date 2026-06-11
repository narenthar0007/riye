class CreateTeamsAndRefactorWorkers < ActiveRecord::Migration[8.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :nature_of_skill, null: false, default: 'local_team'
      t.references :team_lead, null: false, foreign_key: { to_table: :workers }
      t.timestamps
    end
    add_reference :workers, :team, foreign_key: true
    remove_column :workers, :nature_of_skill, :string, array: true, default: []
  end
end
