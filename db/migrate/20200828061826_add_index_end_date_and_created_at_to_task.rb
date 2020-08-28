class AddIndexEndDateAndCreatedAtToTask < ActiveRecord::Migration[6.0]
  def change
    add_index :tasks, :end_date
    add_index :tasks, :created_at
    add_index :tasks, %i[end_date created_at], order: { end_date: :desc, created_at: :desc }, name: 'index_tasks_on_end_date_desc_and_created_at_desc'
    add_index :tasks, %i[end_date created_at], order: { end_date: :asc, created_at: :desc }, name: 'index_tasks_on_end_date_asc_and_created_at_desc'
  end
end
