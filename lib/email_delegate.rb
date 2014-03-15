class EmailDelegate < SimpleDelegator
  attr_reader :recipient

  def for_recipient=(recipient)
    @recipient = recipient
  end

  def mappings
    {
      "%pixel" => tracking,
      "%name" => recipient.name,
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
