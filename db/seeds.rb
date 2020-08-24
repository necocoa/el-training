5.times do |n|
  Task.create!(
    name: "タスク #{n + 1}",
    description: "タスク #{n + 1}の説明文。"
  )
end
