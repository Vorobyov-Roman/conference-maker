class AddTopicRefToApplication < ActiveRecord::Migration[5.0]
  def change
    add_reference :applications, :topic, foreign_key: true, index: true
  end
end
