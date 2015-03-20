
module AppContainer

class PBXGroup

  attr_accessor :sourceTree
  attr_accessor :name
  attr_accessor :children

  def initialize
    super(self)
    @children = nil
    @name = nil
    @sourceTree = nil
  end

end

end