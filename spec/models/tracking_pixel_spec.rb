# == Schema Information
#
# Table name: tracking_pixels
#
#  id                :integer          not null, primary key
#  tracking          :string(255)
#  user_id           :integer
#  campaign_id       :integer
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
  let(:user) { double(id: 1) }
  let(:campaign) { double(id: 1) }
  subject(:tracking_pixel) { create(:tracking_pixel) }

  it "should not have a tracking pixel on creation" do
    expect(tracking_pixel.tracking).to be_nil
  end
end


