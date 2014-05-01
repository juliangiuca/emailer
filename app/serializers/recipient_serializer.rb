class RecipientSerializer < ActiveModel::Serializer
  attributes :id, :email_address, :name, :tracking_pixel

  has_one :tracking_pixel

  def tracking_pixel
    scope.tracking_pixels.where(contact_id: object.id).first
  end
end
