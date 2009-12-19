require 'C:\Ruby\lib\ruby\gems\1.8\gems\twitter-0.7.9\lib\twitter.rb'
require 'net/http'

class DefaultController < ApplicationController
  # POST /
  def create
    @username = params[:username] 
    @password = params[:password]
    
    # log onto twitter
    httpauth = Twitter::HTTPAuth.new(@username, @password)
    httpauth.options[:ssl] = true
    
    # get the tweets
    client = Twitter::Base.new(httpauth)
    
    file = File.new('tweets.raw', 'w')
    client.home_timeline.each { |tweet| file.puts(tweet.text) }
    file.close
    
    @tweets =  client.home_timeline.map { |tweet| 
       {:user => tweet.user.screen_name, 
         :text => expand_tweet_user(tweet.text), 
	 :at => tweet.created_at, 
	 :url => 'http://twitter.com/%s/statuses/%s' % [tweet.user.screen_name, tweet.id]}
    }
    
    file = File.new('tweets.modified', 'w')
    @tweets.each { |tweet| file.puts(tweet[:text]) }
    file.close
    
    # go to the default page
    render :action => "index"
  end
  
  private
  def expand_tweet_user(tweet)
	 if tweet == nil then return tweet end
		  
	 regex = /(http:\/\/|https:\/\/)([a-zA-Z0-9][-\.\/a-z0-9]*[\/a-zA-Z0-9]+)/ 
	 a_tag_format = '<a href="%1$s">%1$s</a>'
	  
	new_tweet = tweet.clone()
	tweet.scan(regex) {|match, group| 
		url = match + group 
		isRedirect = false
		begin 
			Net::HTTP.get_response(URI.parse(url)) do |response|
				isRedirect = response.is_a?(Net::HTTPRedirection)
			end
		rescue EOFError
		end
		if isRedirect
			new_tweet.sub!(url, a_tag_format % response['location']) 
		else
			new_tweet.sub!(url, a_tag_format % url)
		end
		}
		
	return new_tweet		
	end
  
  end