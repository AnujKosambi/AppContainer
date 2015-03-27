require_relative '../abstract_object'

module AppContainer

  class XCConfigurationList < AbstractObject

    Fields = [
      'buildConfigurations',
      'defaultConfigurationIsVisible',
      'defaultConfigurationName'
    ]

    def initialize(hash={})
      super(self,{:Fields => Fields,:Hash => hash})
    end

  end
end