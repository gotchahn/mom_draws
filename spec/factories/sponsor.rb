FactoryGirl.define do
  sequence :sponsor_email do |n|
    "sponsor_#{n}@example.com"
  end

  factory :sponsor do
    name "Mucup Mami"
    email { generate(:sponsor_email) }
    phone "123"
  end

end
