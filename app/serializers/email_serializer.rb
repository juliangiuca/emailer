class EmailSerializer < ActiveModel::Serializer
  attributes :id, :body, :subject
end