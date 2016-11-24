FactoryGirl.define do

  factory :user do
    name "John Doe"
    email
    login
    password "password"

    transient do
      created_conferences_count 0
      organized_conferences_count 0
      moderated_topics_count 0
      sent_applications_count 0
      reviews_count 0
    end

    after :build do |this, e|
      create_list :conference, e.created_conferences_count, creator: this
      create_list :conference, e.organized_conferences_count, organizers: [this]
      create_list :topic, e.moderated_topics_count, moderators: [this]
      create_list :application, e.sent_applications_count, sender: this
      create_list :review, e.reviews_count, reviewer: this
    end
  end

end
