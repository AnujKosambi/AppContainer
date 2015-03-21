require_relative '../abstract_object'
class PBXResourcesBuildPhase < AppContainer::AbstractObject

  attr_accessor :buildActionMask
  attr_accessor :files
  attr_accessor :runOnlyForDeploymentPostprocessing

  def initialize(hash={})
    super(self)
    @buildActionMask = hash['buildActionMask']
    @files = hash['files']
    @runOnlyForDeploymentPostprocessing = hash['runOnlyForDeploymentPostprocessing']
  end
end