FactoryGirl.define do
  sequence :email do |n|
    "user_#{n}@example.com"
  end

  factory :user do
    email
    name "mucup"
    password "mucup2016"
  end
end
