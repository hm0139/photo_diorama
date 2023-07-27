class AddKindsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :kinds, :integer, null: false, default: 0
  end
end
