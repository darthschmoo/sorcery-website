
class PageTree
  def initialize
    @root = PageTreeNode.new( "/", Page.root )
    
    for page in Page.all
      directories = page.slug.split("/")
      
      tnode = @root
      for dir in directories
        next if dir.blank?
        
        if tnode[dir].nil?
          tnode << PageTreeNode.new( dir )
        end
        tnode = tnode[dir]
      end
      tnode.content = page
    end
  end
  
  def root
    @root
  end
  
  def depth_first_traverse( &block )
    rval = []
    stack = [ @root ]
    
    while node = stack.pop
      rval << node
      sorted_child_names = node.children.map(&:name).sort
      
      for child_name in sorted_child_names
        stack << node[child_name]
      end
    end
    
    if block_given?
      rval.each{ |node| yield node }
    end
    
    rval
  end
  
  # returns the pages/content, not the TreeNodes
  def each &block
    for treenode in self.depth_first_traverse
      if block_given? && treenode.page?
        yield treenode.content
      end
    end
  end
  
  def to_a
    rval = []
    self.each{ |content| rval << content }
    rval.compact
  end
end