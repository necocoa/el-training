class AddCounterToUser < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :tasks_count, :integer, default: 0, null: false
    Task.counter_culture_fix_counts
  end

  def down
    remove_column :users, :tasks_count
  end
end
