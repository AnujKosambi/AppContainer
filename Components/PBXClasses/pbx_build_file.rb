require_relative '../abstract_object'

module AppContainer
  class PBXBuildFile < AbstractObject

    attr_accessor :fileRef
    attr_accessor :settings

    def initialize(hash={})
      super(self,{:Fields => Fields,:Hash => hash})
    end
  end
end
