# README

## ER図
```plantuml
skinparam defaultFontName Menlo
skinparam backgroundColor #FFFFFE

entity users {
  id: integer (PK)
  --
  login_id: string
  password_digest: string
  nickname: string
  role: integer
}

entity tasks {
  id: integer (PK)
  --
  name: string
  description: text
  status: integer
  priority: integer
  end_period: datetime
  user_id: integer (FK)
}

entity labels {
  id: integer (PK)
  --
  name: string
}

entity task_labels {
  id: integer (PK)
  --
  task_id: integer (FK)
  label_id: integer (FK)
}


users --o{ tasks
tasks --o{ task_labels
labels --o{ task_labels

```