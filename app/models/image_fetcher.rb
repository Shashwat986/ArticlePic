class ImageFetcher
  @@sources = ['splashbase', 'unsplash', 'placeholder']

  def self.getSourceClass source
    case source
    when 'splashbase'
      ImageFetcher::SplashbaseFetcher
    when 'unsplash'
      ImageFetcher::UnsplashFetcher
    when 'placeholder'
      ImageFetcher::PlaceholderFetcher
    else
      raise ArgumentError
    end
  end

  def initialize keyword
    @keyword = keyword
  end

  def fetch
    resp = []
    @@sources.each do |source|
      begin
        resp = self.class.getSourceClass(source).new.fetch(@keyword)
      rescue => e
        puts "Failed fetching from #{source}"
        puts e
      end
      break unless resp.blank?
    end

    resp
  end
end

class ImageFetcher::SplashbaseFetcher
  def fetch keyword
    res = RestClient.get('http://www.splashbase.co/api/v1/images/search', params: {query: keyword})

    JSON.parse(res.body)['images'].map do |obj|
      #w,h = FastImage.size(obj['large_url'])
      w,h = nil,nil

      {
        url: obj['large_url'],
        url_small: obj['url'],

        uuid: obj['id'],
        keywords: [keyword],
        description: nil,
        width: w,
        height: h,

        source: 'splashbase',
        raw: obj.to_json
      }
    end
  end
end

class ImageFetcher::UnsplashFetcher
  def fetch keyword
    res = RestClient.get('https://api.unsplash.com/search/photos', params: {
      client_id: '208e9e0d979b7ae4e762ecaa50a9a580bcc173ec11ab34932d3ce51d06135ad1',
      query: keyword
    })

    JSON.parse(res.body)['results'].map do |obj|
      keywords = [keyword]

      obj['tags'].each do |tag|
        keywords << tag['title']
      end

      {
        url: obj['urls']['full'],
        url_small: obj['urls']['small'],
        url_other: obj['urls']['raw'],

        uuid: obj['id'],
        keywords: keywords,
        description: obj['description'] || obj['alt_description'],
        width: obj['width'],
        height: obj['height'],

        source: 'unsplash',
        raw: obj.to_json
      }
    end
  end
end

class ImageFetcher::PlaceholderFetcher
  def fetch keyword, width = 400, height = 300
    escaped_keyword = CGI::escape(keyword)

    [
      {
        url: "https://via.placeholder.com/400x300?text=#{escaped_keyword}",
        uuid: "400x300?text=#{escaped_keyword}",
        keywords: [keyword],
        description: "Placeholder for #{keyword}",
        width: width,
        height: height,

        source: 'placeholder'
      }
    ]
  end
end
