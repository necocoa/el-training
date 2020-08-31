class AddReferenceUserToTask < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM tasks;'
    change_table :tasks do |t|
      t.references :user, foreign_key: true, null: false
    end
  end

  def down
    remove_reference :tasks, :user
  end
end
