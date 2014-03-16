class EmailDelegate < SimpleDelegator
  attr_accessor :tracking_pixel

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
  def recipient
    @recipient ||= tracking_pixel.contact
  end

  def tracking
   %Q|<img src="#{Settings.tracking_url}#{tracking_pixel.tracking}">|
  end

end
