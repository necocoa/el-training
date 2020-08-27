class Task < ApplicationRecord
  validates :name, presence: true, length: { in: 1..50 }
  validates :description, length: { maximum: 1000 }

  scope :end_date_sort, lambda { |sort_method|
    case sort_method.downcase
    when 'asc' then order(end_date: :asc)
    when 'desc' then order('end_date IS NULL, end_date desc')
    end
  }
end
