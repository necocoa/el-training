class CreateLabels < ActiveRecord::Migration[6.0]
  def change
    create_table :labels do |t|
      t.timestamps

      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.index %i[user_id name], unique: true
    end
  end
end
