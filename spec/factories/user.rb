FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "John #{n} Doe" }
    sequence(:email_address) { |n| "john#{n}@example.com" }

    factory :user_with_email_and_contacts do
      sequence(:name) { |n| "John #{n} Doe" }
      sequence(:email_address) { |n| "john#{n}@example.com" }

      after(:create) do |user|
        create_list(:email, 1, user_id: user.id)
        create_list(:contact, 1, user_id: user.id)
      end
    end

  end
end

