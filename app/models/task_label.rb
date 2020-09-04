class TaskLabel < ApplicationRecord
  belongs_to :task
  belongs_to :label

  validates :label_id, uniqueness: { scope: %i[label_id task_id] }
end
