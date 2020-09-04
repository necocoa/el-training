class Task < ApplicationRecord
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels
  belongs_to :user

  validates :name, presence: true, length: { in: 1..50 }
  validates :description, length: { maximum: 1000 }

  enum status: { not_started: 0, in_start: 1, completed: 2 }
  enum priority: { low: 0, middle: 1, high: 2 }

  def labels_name
    labels.map(&:name)
  end
end
