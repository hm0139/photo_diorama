class CreateCommissions < ActiveRecord::Migration[7.0]
  def change
    create_table :commissions do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.date :limit_date, null: false
      t.integer :reward, null: false
      t.boolean :directly, null: false, default: false
      t.string :contractor
      t.references :user
      t.timestamps
    end
  end
end
