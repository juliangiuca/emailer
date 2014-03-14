FactoryGirl.define do
  factory :email do
    user
  end

  factory :email_with_recipients, parent: :user_with_email do
    user

    after_create do |email|
      recipient
    end
  end
end

