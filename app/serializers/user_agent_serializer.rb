class UserAgentSerializer < ActiveModel::Serializer
  attributes :referrer, :agent, :created_at, :has_been_googled

end
