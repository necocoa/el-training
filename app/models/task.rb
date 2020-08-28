class Task < ApplicationRecord
  validates :name, presence: true, length: { in: 1..50 }
  validates :description, length: { maximum: 1000 }

  enum status: { not_started: 0, in_start: 1, completed: 2 }

  scope :end_date_sort, ->(sort_key) do
    case sort_key&.downcase
    when 'asc' then order(end_date: :asc)
    when 'desc' then order('end_date IS NULL, end_date desc')
    else order(end_date: :asc)
    end
  end

  def self.statuses_search_values
    statuses.map { |k, v| [human_attribute_enum_value(:status, k), v.to_i] }
  end

  def self.statuses_select_values
    statuses.map { |k, _| [human_attribute_enum_value(:status, k), k] }
  end
end
