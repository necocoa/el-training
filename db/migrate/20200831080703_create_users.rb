class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.timestamps

      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
    end
  end
end
