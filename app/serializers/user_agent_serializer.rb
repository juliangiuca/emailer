class UserAgentSerializer < ActiveModel::Serializer
  attributes :referer, :agent, :created_at

end
