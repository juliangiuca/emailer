# == Schema Information
#
# Table name: tracking_pixels
#
#  id                :integer          not null, primary key
#  tracking          :string(255)
#  contact_id        :integer
#  email_id          :integer
#  created_at        :datetime
#  updated_at        :datetime
#  views             :integer          default(0)
#  date_first_viewed :datetime
#  sent              :datetime
#  time_viewed       :integer          default(0)
#


require_relative "../spec_helper"
require_relative "../../app/models/tracking_pixel"

describe TrackingPixel do
  subject(:tracking_pixel) { create(:tracking_pixel, contact_id: 1) }

  it "should not have a tracking pixel on creation" do
    expect(tracking_pixel.tracking).to be_nil
  end

  describe "generate_token" do
    let(:user) { create(:user_with_email_and_contacts) }
    let(:email) { user.emails.first }
    let(:contact) { user.contacts.first }
    let(:tp_params) { {email_id: email.id, contact_id: contact.id} }
    subject(:generate_token) { TrackingPixel.generate_token(tp_params) }

    it "should generate a tracking token" do
      expect( generate_token.tracking ).to be_present
    end
    it "should merge with the existing options"
  end
end


