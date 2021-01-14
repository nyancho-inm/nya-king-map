class CreateCats < ActiveRecord::Migration[6.0]
  def change
    create_table :cats do |t|
      t.text :message, null: false
      t.integer :prefecture_id, null: false
      t.string :area, null: false
      t.string :place
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
