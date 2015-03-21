require_relative 'abstract_object'
module AppContainer
  class PBXSourcesBuildPhase < AbstractObject

    attr_accessor :buildActionMask
    attr_accessor :files
    attr_accessor :runOnlyForDeploymentPostprocessing

    def initialize(hash={})
      super(self)
      @buildActionMask = hash['@buildActionMask']
      @files = hash['files']
      @runOnlyForDeploymentPostprocessing = hash['runOnlyForDeploymentPostprocessing']
    end
  end
end