require_relative '../abstract_object'

module AppContainer

  class PBXFileReference < AbstractObject
    Fields = ['explicitFileType',
                'lastKnownFileType',
                'path',
                'sourceTree',
                'name',
                'includeInIndex']

    def initialize(hash={})
      super(self,{:Fields => Fields,:Hash => hash})
    end

  end
end