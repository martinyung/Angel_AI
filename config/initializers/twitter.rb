SuicideDetector::Application.configure do
    config.after_initialize do
        config.twitter = Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV["CONSUMER_API_KEY"]
          config.consumer_secret     = ENV["CONSUMER_SECRET_KEY"]
          config.access_token        = ENV["ACCESS_TOKEN"]
          config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
        end
    end
end