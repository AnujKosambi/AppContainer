require_relative 'abstract_object'

module AppContainer
  class PBXBuildFile < AbstractObject

    attr_accessor :fileRef
    def initialize(hash={})
      super(self)
      @fileRef = hash['fileRef']
    end
  end
end
