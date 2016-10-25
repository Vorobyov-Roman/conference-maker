class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :title
      t.text :description
      t.timestamps

      t.references :conference, foreign_key: true, index: true
    end
  end
end
