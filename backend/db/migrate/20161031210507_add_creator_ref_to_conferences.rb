class AddCreatorRefToConferences < ActiveRecord::Migration[5.0]
  def change
    add_reference :conferences, :creator,
                  index: true,
                  foreign_key: { to_table: :users }
  end
end
