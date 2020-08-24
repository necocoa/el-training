class Task < ApplicationRecord
  validates :name, presence: true, length: { in: 1..50 }
  validates :description, length: { in: 0..1000 }
end
