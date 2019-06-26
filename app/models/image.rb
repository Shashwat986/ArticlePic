class Image < ApplicationRecord
  has_and_belongs_to_many :documents
  has_many :keyword_ids, class_name: 'Keyword'

  after_create :create_keywords

  serialize :keywords, JSON

  def create_keywords
    self.keywords.each do |keyword|
      Keyword.where(keyword: keyword, image_id: self.id).first_or_create
    end
  end

  def self.fetch_image word
    keyword = Keyword.where(keyword: word).last
    if keyword.present?
      return keyword.image
    end

    resp = ImageFetcher.new(word).fetch.first

    raise StandardError if resp.nil?

    Image.create!(resp)
  end

  def small
    url_small || url
  end
end
