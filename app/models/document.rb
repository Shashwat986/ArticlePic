class Document < ApplicationRecord
  has_and_belongs_to_many :images
  has_one :parsed, class_name: 'ParsedDocument'
end
