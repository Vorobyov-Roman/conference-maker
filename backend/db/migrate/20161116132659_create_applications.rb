class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.string :title
      t.text :description
      t.timestamps

      t.references :sender, index: true, foreign_key: { to_table: :users }
    end
  end
end
