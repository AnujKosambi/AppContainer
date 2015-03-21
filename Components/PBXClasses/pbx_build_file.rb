require_relative '../abstract_object'

module AppContainer
  class PBXBuildFile < AbstractObject

    attr_accessor :fileRef
    attr_accessor :settings

    def initialize(hash={})
      super(self)
      @fileRef = hash['fileRef']
      @settings = nil
    end
  end
end
