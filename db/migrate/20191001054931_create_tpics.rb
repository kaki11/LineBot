class CreateTpics < ActiveRecord::Migration[5.2]
  def change
    create_table :tpics do |t|
      t.references :user, foreign_key: true
      t.string :send_message
      t.string :receive_message

      t.timestamps
    end
  end
end
