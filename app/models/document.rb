class Document < ApplicationRecord
  has_and_belongs_to_many :images
  has_one :parsed_document
  alias_attribute :parsed, :parsed_document

  belongs_to :author, class_name: 'User'
  alias_attribute :user, :author

  def parse
    parsed_document = ParsedDocument.parse(self)
  end

  def parse!
    parsed_document = ParsedDocument.parse!(self)
  end

  def get_images
    self.parse if self.parsed.nil?

    self.parsed.keywords.each do |word|
      image = Image.fetch_image(word)
      self.images << image
    end

    self.save
  end

  def get_images!
    self.images = []
    self.save
    self.parse!
    self.get_images
  end
end
