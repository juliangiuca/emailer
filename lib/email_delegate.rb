class EmailDelegate < SimpleDelegator
  attr_accessor :tracking_pixel

  def mappings
    {
      "%name" => recipient.name,
    }
  end

  def html
    @html ||= body_with_html
  end

  private
  def body_with_html
    html = <<-HTML
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
        <meta name="apple-mobile-web-app-capable" content="yes" />
      </head>
      <body>
      #{parsed_body}
      #{tracking}
      </body>
    </html>
    HTML
  end

  def parsed_body
    regex = Regexp.new("(#{mappings.keys.join("|")})")
    @parsed_body ||= body.gsub(regex, mappings)
  end

  def recipient
    @recipient ||= tracking_pixel.contact
  end

  def tracking
   @tracking ||= %Q|<img src="#{IMAGE_LOCATION}#{tracking_pixel.tracking}" style="display:none; width:1px; height:1px">|
  end

end
