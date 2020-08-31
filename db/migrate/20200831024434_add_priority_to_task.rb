class AddPriorityToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :priority, :integer, default: 0, null: false
    add_index :tasks, %i[priority created_at], order: { priority: :desc, created_at: :desc }, name: 'index_tasks_on_priority_desc_and_created_at_desc'
    add_index :tasks, %i[priority created_at], order: { priority: :asc, created_at: :desc }, name: 'index_tasks_on_priority_asc_and_created_at_desc'
  end
end
