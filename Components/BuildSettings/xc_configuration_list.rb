require_relative '../abstract_object'

module AppContainer

  class XCConfigurationList < AbstractObject

    ::Fields = [
      'buildConfigurations',
      'defaultConfigurationIsVisible',
      'defaultConfigurationName'
    ]

    def initialize(hash={})
      super(self)
      ::Fields.each do |attr|
        self.class.send(:attr_accessor,attr)
        instance_variable_set('@'+attr,hash[attr])
      end
    end

  end
end