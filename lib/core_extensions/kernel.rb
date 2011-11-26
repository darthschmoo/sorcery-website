module Kernel
  def tempfile &block
    @tempfile_suffix ||= 0
    @tempfile_suffix += 1
    
    t = Tempfile.new "sorcery.tmp.#{@tempfile_suffix}"
    
    begin
      yield t
    ensure
      t.close
      t.unlink
    end
  end
end