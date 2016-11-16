class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :status, default: 0
      t.text :comment
      t.timestamps

      t.references :author, foreign_key: { to_table: :users }
      t.references :reviewer, foreign_key: { to_table: :users }

      t.index [:reviewer_id, :author_id]
    end
  end
end
