# Configr

module Configr
  attr_reader :data
  
  class Configr
    def initialize( data )
      @data = {}
      if data.is_a?(String)
        data = YAML.load( data )
      end
      
      apply_hash( data )
    end
    
    def apply_hash( hash )
      for k, v in hash
        if v.is_a?(Hash)
          puts v.inspect
          create_method( k, Configr.new(v) )
        else
          create_method( k, v )
        end
      end
    end

    def []( key )
      @data[key]
    end
    
    def []=( key, val )
      apply_hash( { key => val } )
    end
    
    def create_method( method_name, value )
      method_name = method_name.to_sym
      
      @data[method_name] = value
      
      mod = eval <<-EOS
        Module.new do
          def #{method_name}
            @data[:#{method_name}]
          end
        end
      EOS
      
      self.extend( mod )
    end
    
    def method_missing( *args )
      # TODO: check to see if existing methods are being overwritten?
      if args[0].match( /=$/ )
        apply_hash( { args[0].to_s.chop => args[1] } )
        args[1]
      else
        nil
      end
    end
  end
end