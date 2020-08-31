user = User.create!(
  name: 'seed user',
  email: 'seed@example.com',
  password_digest: 'password'
)

5.times do |n|
  user.tasks.create!(
    name: "タスク #{n + 1}",
    description: "タスク #{n + 1}の説明文。"
  )
end
