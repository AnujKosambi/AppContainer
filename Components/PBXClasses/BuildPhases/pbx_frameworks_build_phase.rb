require_relative '../../abstract_object'

module AppContainer
  class PBXFrameworksBuildPhase < AbstractObject

    Fields = ['buildActionMask',
              'files',
              'runOnlyForDeploymentPostprocessing']

    def initialize(hash={})
      super(self)
      Fields.each do |attr|
        self.class.send(:attr_accessor,attr)
        instance_variable_set('@'+attr,hash[attr])
      end
    end
  end
end