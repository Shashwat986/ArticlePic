class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :text
  attribute (:title) { 'Sample title' }
  attributes :url, :keywords
  has_many :images

  def url
    Rails.application.routes.url_helpers.html_document_path(object.id)
  end

  def keywords
    object.parsed.keywords
  end
end
