class CreateTaskLabels < ActiveRecord::Migration[6.0]
  def change
    create_table :task_labels do |t|
      t.timestamps

      t.references :task, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true
      t.index %i[task_id label_id], unique: true
    end
  end
end
