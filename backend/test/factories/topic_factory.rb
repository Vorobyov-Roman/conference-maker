FactoryGirl.define do

  factory :topic do
    title
    description
    association :conference, strategy: :build

    transient do
      moderators_count 0
      applications_count 0
    end

    after :build do |this, e|
      create_list :user, e.moderators_count, moderated_topics: [this]
      create_list :application, e.applications_count, topic: this
    end
  end

end
