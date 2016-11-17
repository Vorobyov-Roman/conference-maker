class AddConferenceRefToApplication < ActiveRecord::Migration[5.0]
  def change
    add_reference :applications, :conference, foreign_key: true, index: true
  end
end
