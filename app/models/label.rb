class Label < ApplicationRecord
  has_many :task_labels, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, length: { in: 1..50 }, uniqueness: { scope: %i[name user_id] }
end
