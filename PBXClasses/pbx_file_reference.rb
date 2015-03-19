require_relative 'object'

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
      @explicitFileType = nil
      @lastKnownFileType = nil
      @path = nil
      @sourceTree = nil
      @includeInIndex = nil
    end

  end
end