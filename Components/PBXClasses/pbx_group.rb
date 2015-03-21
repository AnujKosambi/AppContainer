require_relative '../abstract_object'
module AppContainer

class PBXGroup < AbstractObject

  attr_accessor :sourceTree
  attr_accessor :name
  attr_accessor :children
  attr_accessor :path

  def initialize(hash={})
    super(self)
    @children = hash['children']
    @name = hash['name']
    @path = hash['path']
    @sourceTree = hash['sourceTree']
  end

end

end