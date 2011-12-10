require 'action_controller/test_case'

# Used by a handful of actions outside controller/views, to generate links.
class BogusRequest < ActionController::TestRequest
  attr_reader :host, :protocol, :port, :env
  
  def initialize( path_parameters = {} )
    @env = {}
    @env["action_dispatch.request.path_parameters"] = path_parameters
    
    @host = Sorcery.config.request.host[Rails.env] || "localhost"
    @protocol = Sorcery.config.request.protocol[Rails.env] || "http"
    @port = Sorcery.config.request.port[Rails.env] || "3000"
  end
end

def BogusRequest( path_parameters = {} )
  apc = ApplicationController.new
  apc.request = BogusRequest.new( path_parameters )

  return apc
end