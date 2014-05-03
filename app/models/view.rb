# == Schema Information
#
# Table name: views
#
#  id                :integer          not null, primary key
#  tracking_pixel_id :integer
#  agent             :string(1000)
#  referer           :string(1000)
#  created_at        :datetime
#  time              :integer          default(0)
#  googled           :boolean          default(FALSE)
#

class View < ActiveRecord::Base
  belongs_to :tracking_pixel

end
