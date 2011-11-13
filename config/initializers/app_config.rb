m = Module.new do
  def config
    return @sorcery_config
  end

  def initialize_sorcery_config
    config_file = File.join( Rails.root, "config", "app.yml" )
    @sorcery_config = Configr::Configr.new( File.read( config_file ) )
  end
end

Sorcery.extend m
Sorcery.initialize_sorcery_config
  