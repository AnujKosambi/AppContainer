require_relative '../../abstract_object'
module AppContainer
  class PBXNativeTarget < AbstractObject
    Fields =
        ['buildConfigurationList',
          'buildPhases',
          'buildRules',
          'dependencies',
          'name',
          'productName',
          'productReference',
          'productType']

    def initialize(hash={})
      super(self,{:Fields => Fields,:Hash => hash})
    end


  end
end
