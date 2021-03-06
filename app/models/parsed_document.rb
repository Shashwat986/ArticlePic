class ParsedDocument < ApplicationRecord
  belongs_to :document

  serialize :keywords, JSON

  def parsed?
    self.keywords.present?
  end

  def self.parse document, force = false
    parsed_document = self.where(document_id: document.id).first_or_create

    if !force && parsed_document.parsed?
      return parsed_document
    end

    words = $tfidf.run(document)
    parsed_document.keywords = words
    parsed_document.save

    parsed_document
  end

  def self.parse! document
    self.parse document, true
  end
end
