FactoryGirl.define do

  factory :topic do
    title
    description
    association :conference, strategy: :build

    transient do
      moderators_count 0
    end

    after :build do |this, eval|
      create_list :user, eval.moderators_count, moderated_topics: [this]
    end
  end

end
