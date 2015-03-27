require_relative '../../abstract_object'
module AppContainer
  class PBXSourcesBuildPhase < AbstractObject

    Fields = ['buildActionMask',
              'files',
              'runOnlyForDeploymentPostprocessing']

    def initialize(hash={})
      super(self,{:Fields => Fields,:Hash => hash})
    end
  end
end