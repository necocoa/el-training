class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy
  after_destroy :one_or_more_admin_users

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :admin, inclusion: { in: [true, false] }

  scope :join_tasks_count, -> { left_joins(:tasks).select('users.*, COUNT(tasks.id) AS tasks_count').group(:id) }

  def one_or_more_admin_users
    return if User.where(admin: true).size.positive?

    errors.add :admin, '管理者が0人になるため削除できません。'
    raise ActiveRecord::Rollback
  end
end
