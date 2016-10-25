module Associations::TopicsModerators

  def self.association_for_user target
    params = {
      class_name:  "Topic",
      foreign_key: "moderator_id",
      join_table:  "moderators_topics"
    }

    target.has_and_belongs_to_many :moderated_topics, params
  end

  def self.association_for_topic target
    params = {
      class_name:              "User",
      association_foreign_key: "moderator_id",
      join_table:              "moderators_topics"
    }

    target.has_and_belongs_to_many :moderators, params
  end
  
end
