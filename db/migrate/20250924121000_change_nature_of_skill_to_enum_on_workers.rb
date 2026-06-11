class ChangeNatureOfSkillToEnumOnWorkers < ActiveRecord::Migration[8.0]
  def up
    remove_column :workers, :nature_of_skill, :string, array: true, default: []
    add_column :workers, :nature_of_worker, :integer, default: 0
  end

  def down
    remove_column :workers, :nature_of_worker, :integer
    add_column :workers, :nature_of_skill, :string, array: true, default: []
  end
end
