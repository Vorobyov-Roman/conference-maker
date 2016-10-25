class CreateJoinTableTopicModerator < ActiveRecord::Migration[5.0]
  def change
    create_join_table :topics, :moderators do |t|
      t.index [:topic_id, :moderator_id]
    end
  end
end
