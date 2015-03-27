require_relative '../abstract_object'

module AppContainer

class PBXProject < AbstractObject

  Fields = ['includeInIndex',
            'buildConfigurationList',
            'compatibilityVersion',
            'developmentRegion',
            'hasScannedForEncodings',
            'knownRegions',
            'mainGroup',
            'productRefGroup',
            'projectDirPath',
            'projectRoot',
            'targets']


  def initialize(hash={})
    super(self,{:Fields => Fields,:Hash => hash})
  end



end

end