class CampaignDelegate < SimpleDelegator
  attr_reader :user

  def for_user=(user)
    @user = user
  end

  def mappings
    {
      "%pixel" => tracking,
      "%name" => user.name,
    }
  end

  def parsed_body
    regex = Regexp.new("(#{mappings.keys.join("|")})")
    @parsed_body ||= body.gsub(regex, mappings)
  end

  private
  def tracking_pixel
   @tracking_pixel ||= TrackingPixel.generate_tokens(campaign_id: self.id, user_id: user.id, sent: Date.today)
  end

  def tracking
   %Q|<img src="#{Settings.tracking_url}#{tracking_pixel.tracking}">|
  end

end
