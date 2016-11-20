FactoryGirl.define do

  factory :conference do
    title
    description
    association :creator, factory: :user, strategy: :build

    transient do
      organizers_count 0
      topics_count 0
    end

    after :build do |this, eval|
      create_list :user, eval.organizers_count, organized_conferences: [this]
      create_list :topic, eval.topics_count, conference: this
    end
  end

end
