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

    factory :accepted_application do
      after :build do |this, e|
        create_list :review, 1, application: this, status: :accepted
      end
    end

    factory :rejected_application do
      after :build do |this, e|
        create_list :review, 1, application: this, status: :rejected
      end
    end

    factory :disputable_application do
      after :build do |this, e|
        create_list :review, 1, application: this, status: :disputable
      end
    end
  end

end
