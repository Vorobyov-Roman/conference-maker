FactoryGirl.define do

  sequence :login do |n|
    "#{n.ordinalize}_user"
  end

  sequence :email do |n|
    "#{n.ordinalize}@gmail.com"
  end

  sequence :title do |n|
    "#{n.ordinalize}_title"
  end

  sequence :description do |n|
    "#{n.ordinalize}_description"
  end

end
