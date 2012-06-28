class String
  def filenameize
    self.downcase.gsub(/[^a-z0-9.]/, '_').gsub(/_{2,}/, "_").gsub(/_*\._*/,".")
  end
end