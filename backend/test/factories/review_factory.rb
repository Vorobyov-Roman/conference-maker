FactoryGirl.define do

  factory :review do
    status :needs_corrections
    comment "Dummy comment"
    association :application, strategy: :build
    association :reviewer, factory: :user, strategy: :build
  end

end
