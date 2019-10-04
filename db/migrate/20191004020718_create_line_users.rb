class CreateLineUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :line_users do |t|
      t.references :user, foreign_key: true
      t.string :line_id

      t.timestamps
    end
  end
end
