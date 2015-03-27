require_relative '../../abstract_object'
class PBXResourcesBuildPhase < AppContainer::AbstractObject

  Fields = ['buildActionMask',
            'files',
            'runOnlyForDeploymentPostprocessing']

  def initialize(hash={})
    super(self,{:Fields => Fields,:Hash => hash})
  end
end