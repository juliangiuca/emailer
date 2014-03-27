class RecipientSerializer < ActiveModel::Serializer
  attributes :id, :email_address, :name
end
