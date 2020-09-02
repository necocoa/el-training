class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  scope :join_tasks_count, -> { joins(:tasks).select('users.*, COUNT(tasks.id) AS tasks_count').group(:id) }
end
