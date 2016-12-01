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

    factory :updated_application do
      association :previous_version, factory: :application, strategy: :build
    end
  end

end
