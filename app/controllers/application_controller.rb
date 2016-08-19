class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def load_tweets
  	@tweets = @twitter.user_timeline[0..4]
  end  
end
