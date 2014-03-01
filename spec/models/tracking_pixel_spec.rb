
require_relative "../spec_helper"
require_relative "../../app/models/tracking_pixel"

describe TrackingPixel do
  let(:user) { double(id: 1) }
  let(:campaign) { double(id: 1) }
  subject(:tracking_pixel) { TrackingPixel.create!(user: user, campaign: campaign) }

  it "should not have a tracking pixel on creation" do
    expect(tracking_pixel.tracking).to be_nil
  end
end


