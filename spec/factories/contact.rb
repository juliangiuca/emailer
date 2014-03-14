FactoryGirl.define do
  factory :contact do
    sequence(:name) { |n| "John #{n} Doe" }
    sequence(:email_address) { |n| "johnsfriend#{n}@example.com" }
    user
  end
end

