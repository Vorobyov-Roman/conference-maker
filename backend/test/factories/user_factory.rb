FactoryGirl.define do

  factory :user do
    name "John Doe"
    email
    login
    password "password"

    factory :creator do
      transient do
        conferences_count 1
      end

      after :build do |this, eval|
        create_list :conference, eval.conferences_count, creator: this
      end
    end

    factory :organizer do
      transient do
        conferences_count 1
      end

      after :build do |this, eval|
        create_list :conference, eval.conferences_count, organizers: [this]
      end
    end

    factory :moderator do
      transient do
        topics_count 1
      end

      after :build do |this, eval|
        create_list :topic, eval.topics_count, moderators: [this]
      end
    end
  end

end
