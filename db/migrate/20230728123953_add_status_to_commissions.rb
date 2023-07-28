class AddStatusToCommissions < ActiveRecord::Migration[7.0]
  def change
    add_column :commissions, :status, :integer, null: false, default: 0
  end
end
