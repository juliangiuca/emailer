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
   @tracking ||= %Q|<img src="#{IMAGE_LOCATION}#{tracking_pixel.tracking}">|
  end

end
