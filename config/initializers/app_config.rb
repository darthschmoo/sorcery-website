puts __FILE__

Sorcery.install_fwc_config_from_file( Rails.root.join( "config", "app.rb" ) )


# Tweak a few of the settings
Sorcery.config.book.epubforge_projects_dir.promote_configuration(Rails.env)

for setting in [:host, :protocol, :port]
  Sorcery.config.request[setting].promote_configuration( Rails.env )
end

