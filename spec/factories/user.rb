FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "John #{n} Doe" }
    sequence(:email) { |n| "john#{n}@example.com" }
  end
end

