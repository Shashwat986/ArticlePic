require 'csv'

class Parse
  def initialize
    csv = CSV.open('wordlist.txt', 'r', col_sep: "\t")
    @wordmap = csv.map { |row| [ row[1].downcase , row[2].to_f ] }.to_h
    csv.close
  end

  def get_wordmap
    @wordmap
  end

  def calculate_tfidf docmap
    score = {}
    (@wordmap.keys & docmap.keys).each do |word|
      score[word] = 1.0 * docmap[word] / @wordmap[word]
    end

    score
  end

  MAX_NUMBER_WORDS = 4
  MAX_PERCENTAGE_WORDS = 20

  def run doc
    docmap = get_document_map doc
    tfidf = calculate_tfidf docmap

    limit = [MAX_NUMBER_WORDS, docmap.length * 1.0 * MAX_PERCENTAGE_WORDS / 100].min
    limit = 1 if limit < 1

    top_words = tfidf.sort_by { |key, val| -val }.first(limit).map { |key, val| key }

    top_words
  end

  MIN_THRESHOLD = 0
  ONLY_EXISTING_WORDS = true

  def get_document_map doc
    text = doc.text

    words = text.split()
    docmap = Hash.new(0)
    words.each do |word|
      docmap[word.downcase] += 1
    end

    docmap.select do |key, val|
      val > MIN_THRESHOLD &&
      (!ONLY_EXISTING_WORDS || @wordmap[key].present?)
    end
  end
end
