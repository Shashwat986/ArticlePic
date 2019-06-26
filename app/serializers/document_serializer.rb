class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :text
  attribute (:title) { 'Sample title' }
  attribute :url
  has_many :images

  def url
    Rails.application.routes.url_helpers.html_document_path(object.id)
  end
end
