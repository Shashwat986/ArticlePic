require 'ibm_watson'
class Watson
  include IBMWatson

  def initialize credentials_file_path = 'ibm-credentials.env'
    file = File.open credentials_file_path
    @data = JSON.load file
    @version = '2019-07-12'

    authenticator = Authenticators::IamAuthenticator.new(
      apikey: @data['apikey']
    )

    @natural_language_understanding = NaturalLanguageUnderstandingV1.new(
      version: @version,
      authenticator: authenticator
    )

    @natural_language_understanding.service_url = @data['url']
  end

  def analyze text, features = nil
    resp = @natural_language_understanding.analyze(
      text: text,
      features: features || default_features
    )

    resp.result
  end

  def default_features
    {
      keywords: {}
    }
  end
end
