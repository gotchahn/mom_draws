FactoryGirl.define do
  sequence :mom_email do |n|
    "mami_#{n}@example.com"
  end

  factory :mami do
    name "Mucup Mami"
    email { generate(:mom_email) }
    phone "123"
  end

end
