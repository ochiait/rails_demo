class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :gender
      t.date :birthday
      t.string :hometown
      t.text :remarks

      t.timestamps null: false
    end
  end
end
