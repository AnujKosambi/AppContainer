require_relative '../abstract_object'

module AppContainer
  class XCBuildConfiguration < AbstractObject

    attr_accessor :buildSettings
    attr_accessor :name

    def initialize(hash={})
      super(self)

      @buildSettings = hash['buildSettings']
      @name = hash['name']
      @buildSettings = Hash.new unless @buildSettings
    end

    def prepare_method

      attributes = [ 'ASSETCATALOG_COMPILER_APPICON_NAME',
                     'INFOPLIST_FILE',
                     'INSTALL_PATH',
                     'LD_RUNPATH_SEARCH_PATHS',
                     'PRODUCT_NAME',
                     'STRIP_INSTALLED_PRODUCT',
                     'TARGETED_DEVICE_FAMILY'
      ]

      attributes.each do |attr|
        self.class.send(:attr_accessor,attr)
        self.class.send(:define_method,'#{attr}=') { |value| @buildSettings[attr] = value }
        (class << self; self; end).class_eval do
          define_method(attr) { @buildSettings[attr] }
          define_method(attr+'=') { |value| @buildSettings[attr] = value }
        end
      end
    end

  end
end