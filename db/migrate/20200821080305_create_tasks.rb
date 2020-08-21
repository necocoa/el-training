class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.timestamps

      t.string :name, null: false
      t.text :description, null: false, default: ''
    end
  end
end
