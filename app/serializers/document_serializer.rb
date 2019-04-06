class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :text
  has_many :images
end
