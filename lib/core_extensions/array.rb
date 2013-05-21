class Array
  def shuffle
    self.dup.shuffle!
  end
  
  def shuffle!
    reordered = []
    
    while self.length > 0
      reordered << self.delete_at( rand( self.length ) )
    end
    
    self.concat( reordered )
  end
end