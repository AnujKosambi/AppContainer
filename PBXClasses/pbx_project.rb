require_relative 'abstract_object'

module AppContainer

class PBXProject < AbstractObject
  attr_accessor :includeInIndex
  attr_accessor :buildConfigurationList
  attr_accessor :compatibilityVersion
  attr_accessor :developmentRegion
  attr_accessor :hasScannedForEncodings
  attr_accessor :knownRegions
  attr_accessor :mainGroup
  attr_accessor :productRefGroup
  attr_accessor :projectDirPath
  attr_accessor :projectRoot
  attr_accessor :targets


  def initialize(hash={})
    super(self)
    @attributes = hash['includeInIndex']
    @buildConfigurationList = hash['buildConfigurationList']
    @compatibilityVersion = hash['compatibilityVersion']
    @developmentRegion =  hash['developmentRegion']
    @hasScannedForEncodings =  hash['hasScannedForEncodings']
    @knownRegions =  hash['knownRegions']
    @mainGroup =  hash['mainGroup']
    @productRefGroup =  hash['productRefGroup']
    @projectDirPath =  hash['projectDirPath']
    @projectRoot =  hash['projectRoot']
    @targets =  hash['targets']
  end



end

end