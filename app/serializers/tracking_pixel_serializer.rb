class TrackingPixelSerializer < ActiveModel::Serializer
  attributes :id, :email_id, :contact_id, :time_viewed, :sent, :date_first_viewed, :no_views, :has_been_googled

  def date_first_viewed
    object.date_first_viewed.to_s
  end


  def has_been_googled
    !!_views.where(googled: true).first
  end

  def time_viewed
    _views.sum(:time)
  end

  def no_views
    _views.count
  end

  private
  def _views
    @_views ||= object.views
  end

end
