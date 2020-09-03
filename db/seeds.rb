def create_tasks(user, times_count)
  times_count.times do |n|
    user.tasks.create!(
      name: "#{user.name}のタスク #{n + 1}",
      description: "タスク #{n + 1}の説明文。"
    )
  end
end

seed_user = User.create!(
  name: 'seed user',
  email: 'seed@example.com',
  admin: true,
  password: 'seed_password',
  password_confirmation: 'seed_password'
)
create_tasks(seed_user, 5)

second_seed_user = User.create!(
  name: 'second seed user',
  email: 'seed2@example.com',
  password: 'seed_password',
  password_confirmation: 'seed_password'
)
create_tasks(second_seed_user, 5)
