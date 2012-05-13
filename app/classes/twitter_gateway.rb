# TODO: be able to set up and revoke oauth tokens?
# getting the oauth token in the first place:   http://obi-akubue.org/?p=479
module TwitterGateway  
  def self.setup_gateway
    return if @gw_set_up
    
    Twitter.configure do |config|
      oauth = Sorcery.config.twitter.oauth
      config.consumer_key       = oauth.consumer_key
      config.consumer_secret    = oauth.consumer_secret
      config.oauth_token        = oauth.token
      config.oauth_token_secret = oauth.secret
    end
    
    @gw_set_up = true
  end

  
  setup_gateway

  def self.write( tweet )
    response = Twitter.update( tweet )
  end
end