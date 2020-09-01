class Task < ApplicationRecord
  belongs_to :user
  counter_culture :user

  validates :name, presence: true, length: { in: 1..50 }
  validates :description, length: { maximum: 1000 }

  enum status: { not_started: 0, in_start: 1, completed: 2 }
  enum priority: { low: 0, middle: 1, high: 2 }
end
