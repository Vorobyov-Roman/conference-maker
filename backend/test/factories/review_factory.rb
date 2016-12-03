FactoryGirl.define do

  factory :review do
    status :disputable
    comment "Dummy comment"
    association :application, strategy: :build
    association :reviewer, factory: :user, strategy: :build
  end

end
