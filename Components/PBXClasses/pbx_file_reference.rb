require_relative '../abstract_object'

module AppContainer

  class PBXFileReference < AbstractObject
    Fields = ['explicitFileType',
                'lastKnownFileType',
                'path',
                'sourceTree',
                'name',
                'includeInIndex']

    def initialize(hash={})
      super(self)
      Fields.each do |attr|
        self.class.send(:attr_accessor,attr)
        instance_variable_set('@'+attr,hash[attr])
      end
    end

  end
end