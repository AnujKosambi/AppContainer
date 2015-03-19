require 'object'

module AppContainer

  class PBXFileReference < Object
    attr_accessor :explicitFileType
    attr_accessor :lastKnownFileType
    attr_accessor :path
    attr_accessor :sourceTree
    attr_accessor :name
    attr_accessor :includeInIndex

    def initialize
      super(self)
    end
  end
end