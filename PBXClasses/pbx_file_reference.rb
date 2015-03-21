require_relative 'abstract_object'

module AppContainer

  class PBXFileReference < AbstractObject
    attr_accessor :explicitFileType
    attr_accessor :lastKnownFileType
    attr_accessor :path
    attr_accessor :sourceTree
    attr_accessor :name
    attr_accessor :includeInIndex

    def initialize(hash={})
      super(self)

      @explicitFileType = hash['explicitFileType']
      @lastKnownFileType = hash['lastKnownFileType']
      @path = hash['path']
      @sourceTree = hash['sourceTree']
      @name = hash['name']
      @includeInIndex = hash['includeInIndex']

    end

  end
end