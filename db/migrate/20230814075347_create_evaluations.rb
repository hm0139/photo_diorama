class CreateEvaluations < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluations do |t|
      t.integer :rank, null: false
      t.text :comment, null: false
      t.boolean :reflect, null: false, default: false
      t.references :commission, null: false, foreign_key: true
      t.references :target_user, null: false
      t.references :source_user, null: false
      t.timestamps
    end
    add_foreign_key :evaluations, :users, column: :target_user_id
    add_foreign_key :evaluations, :users, column: :source_user_id
  end
end
