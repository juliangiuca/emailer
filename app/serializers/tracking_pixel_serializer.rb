class TrackingPixelSerializer < ActiveModel::Serializer
  attributes :id, :email_id, :contact_id, :time_viewed, :sent, :date_first_viewed, :views

  def date_first_viewed
    object.date_first_viewed.to_s
  end
end
