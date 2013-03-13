class PageTreeNode < Tree::TreeNode
  def page
    @content
  end
  
  def dir
    @name
  end
  
  def page?
    !@content.nil?
  end
  
  def dir?
    @content.nil?
  end
  
  def calculated_slug
    ( self.parentage.reverse.map(&:name).push( self.name ) ).join("/").gsub( /^\/+/, "/" )
  end
  
  def root?
    self.node_depth == 0
  end
  
  def root
    node = self
    
    while !node.root?
      node = node.parent
    end
    
    node
  end
  
  # modifying original behavior, which sucks
  def parentage
    super || []
  end
end
