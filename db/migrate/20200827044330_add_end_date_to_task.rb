class AddEndDateToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :end_date, :date
  end
end
