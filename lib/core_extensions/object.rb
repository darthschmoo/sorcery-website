class Object
  def umethods
    self.methods.sort - Object.new.methods
  end
end