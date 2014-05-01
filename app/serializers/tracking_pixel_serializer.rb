class TrackingPixelSerializer < ActiveModel::Serializer
  attributes :id, :email_id, :contact_id, :time_viewed, :sent, :date_first_viewed, :views

  has_many :user_agents

  def date_first_viewed
    object.date_first_viewed.to_s
  end

end
