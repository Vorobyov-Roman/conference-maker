class CreateJoinTableConferenceAttendee < ActiveRecord::Migration[5.0]
  def change
    create_join_table :conferences, :attendees do |t|
      t.index [:attendee_id, :conference_id]
    end
  end
end
