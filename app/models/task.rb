class Task < ApplicationRecord
  validates :name, presence: true, length: { in: 1..50 }
  validates :description, length: { maximum: 1000 }
end
