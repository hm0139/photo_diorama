class CreateAchievements < ActiveRecord::Migration[7.0]
  def change
    create_table :achievements do |t|
      t.text :achievement_text
      t.integer :commission_count, null: false, default: 0
      t.text :text
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
