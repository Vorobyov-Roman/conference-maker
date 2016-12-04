FactoryGirl.define do

  factory :conference do
    title
    description
    association :creator, factory: :user, strategy: :build

    transient do
      organizers_count 0
      topics_count 0
      attendees_count 0
    end

    after :build do |this, e|
      create_list :user, e.organizers_count, organized_conferences: [this]
      create_list :topic, e.topics_count, conference: this
      create_list :user, e.attendees_count, attended_conferences: [this]
    end
  end

end
