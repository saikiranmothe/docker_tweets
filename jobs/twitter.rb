require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = 'UOU6DSrukVvzB3X6MmaLzwKDd'
  config.consumer_secret = 'bDUorl9GpyznEwJt8dW9zixUc8wITc3CNw0PR6bZtsWuJqoOAu'
  config.access_token = '2547145790-14nFJBG48EfSkH4PmzElElHzq2WS5TlFUlBee84'
  config.access_token_secret = 'dylYGSkwMDBOCoa51fmkVRMAFGdg0QHyne09crXOlUOFD'
end

search_term = URI::encode('#docker')

SCHEDULER.every '5m', :first_in => 0 do |job|
  begin
    tweets = twitter.search("#{search_term}")

    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end