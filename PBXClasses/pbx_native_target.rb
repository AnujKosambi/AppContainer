require_relative 'abstract_object'
module AppContainer
  class PBXNativeTarget < AbstractObject
    attr_accessor :buildConfigurationList
    attr_accessor :buildPhases
    attr_accessor :buildRules
    attr_accessor :dependencies
    attr_accessor :name
    attr_accessor :productName
    attr_accessor :productReference
    attr_accessor :productType

    def initialize(hash={})
      super(self)
      @buildConfigurationList = hash['buildConfigurationList']
      @buildPhases = hash['buildPhases']
      @buildRules = hash['buildRules']
      @dependencies = hash['dependencies']
      @name = hash['name']
      @productName = hash['productName']
      @productReference = hash['productReference']
      @productType = hash['productType']
    end

  end
end
