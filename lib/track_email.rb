class TrackEmail
  attr_reader :campaign, :email

  def initialize(campaign, user)
    @campaign = campaign
    @user = user
  end

  def body
    parsed_body
  end

  private
  def parsed_body
    @parsed_body ||= campaign.body.gsub("%pixel", tracking_pixel)
  end

  def tracking_pixel
   @tp ||= TrackingPixel.generate_token(campaign_id: campaign.id, user_id: user.id, sent: Date.today)
   %Q|<img src="http://localhost:9292/tp/#{tp.tracking}">|
  end


end
