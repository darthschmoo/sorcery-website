require 'stringio' unless defined?(StringIO)

module RemoteFile
  def self.read( host, file )
    `ssh #{host} "cat #{file}"`
  end
  
  def self.touch( host, file )
    `ssh #{host} "touch #{file}"`
  end
  
  
  def self.append( host, file, data = "", &block )
    StringIO.new do |io|
      io << data
    
      if block_given?
        yield io
      end
    
    end
    io.rewind
    
    # raise "Yeah, didn't think this through.  Tempfile then scp?"
    puts "Dunno if this will work for a binary file."
    `echo "#{io.read}" | ssh #{host} "cat >> #{file}"`
  end
  
  def self.truncate( host, file, size = 0 )
    `ssh #{host} "truncate --size #{size} #{file}"`
  end
  
  def self.overwrite( host, file, data = "", &block )
    self.truncate( host, file )
    self.append( host, file, data, &block )
  end
  
  def self.lsdir( pattern )
    
  end

end