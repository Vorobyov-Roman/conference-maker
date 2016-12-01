class AddParentRefToApplication < ActiveRecord::Migration[5.0]
  def change
    params = {
      foreign_key: { to_table: :applications },
      index: true,
      null: true
    }

    add_reference :applications, :parent, params
  end
end
