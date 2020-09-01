FactoryBot.define do
  factory :task do
    user
    name { 'テストのタスク' }
    description { 'テストのタスクの説明文' }
  end
end
