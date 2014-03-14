FactoryGirl.define do
  factory :tracking_pixel do
    email
    contact

    factory :tracking_pixel_with_tracking do
      email
      contact
      tracking { SecureRandom.urlsafe_base64 }
    end

  end
end
