FactoryGirl.define do

  factory :application do
    title
    description
    association :sender, factory: :user, strategy: :build
    association :topic, strategy: :build

    transient do
      reviews_count 0
    end

    after :build do |this, e|
      create_list :review, e.reviews_count, application: this
    end
  end

end
