class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :value
      t.string :profile

      t.timestamps
    end
    add_index :words, :value, unique: true
    add_index :words, :profile
  end
end
