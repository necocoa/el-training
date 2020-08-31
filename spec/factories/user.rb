FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    sequence(:email) { |i| "factory_#{i}@example.com" }
    password_digest { 'password' }
  end
end
