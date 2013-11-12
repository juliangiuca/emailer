class CampaignDelegate < SimpleDelegator
  attr_reader :user

  def for_user=(user)
    @user = user
  end

  def parsed_body
    @parsed_body ||= body.gsub("%pixel", tracking_pixel)
  end

  private
  def tracking_pixel
   @tp ||= TrackingPixel.generate_token(campaign_id: self.id, user_id: user.id, sent: Date.today)
   %Q|<img src="http://localhost:9292/tp/#{@tp.tracking}">|
  end


end
