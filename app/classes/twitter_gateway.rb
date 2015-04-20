# TODO: be able to set up and revoke oauth tokens?
# getting the oauth token in the first place:   http://obi-akubue.org/?p=479
module TwitterGateway  
  def self.setup_gateway
    return if @gw_set_up || @gw_set_up == false
    
    Twitter.configure do |config|
      oauth = Sorcery.config.twitter.oauth
      config.consumer_key       = oauth.consumer_key
      config.consumer_secret    = oauth.consumer_secret
      config.oauth_token        = oauth.token
      config.oauth_token_secret = oauth.secret
    end
    
    @gw_set_up = true
  rescue Exception => e
    Rails.logger.warn "Twitter gateway not set up.  No tweets will be sent."
    @gw_set_up = false
  end

  
  setup_gateway

  def self.write( tweet )
    if @gw_set_up
      response = Twitter.update( tweet )
    end
  end
end