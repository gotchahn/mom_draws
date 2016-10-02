FactoryGirl.define do
  sequence :email do |n|
    "mami_#{n}@example.com"
  end

  factory :mami do
    name "Mucup Mami"
    email
    phone "123"
  end

end
