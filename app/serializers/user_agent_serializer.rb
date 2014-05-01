class UserAgentSerializer < ActiveModel::Serializer
  attributes :referer, :agent, :created_at, :has_been_googled

end
