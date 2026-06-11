class AddCustomerBudgetToProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :customer_budget, :decimal
  end
end
