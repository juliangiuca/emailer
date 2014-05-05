class EmailSerializer < ActiveModel::Serializer
  attributes :id, :body, :subject, :sent_on, :recipients


  def sent_on
    object.sent_on.to_s
  end

  def recipients
    object.tracking_pixels.count
  end
end
