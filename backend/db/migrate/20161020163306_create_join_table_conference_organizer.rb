class CreateJoinTableConferenceOrganizer < ActiveRecord::Migration[5.0]
  def change
    create_join_table :conferences, :organizers do |t|
      t.index [:organizer_id, :conference_id]
    end
  end
end
