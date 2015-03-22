require_relative '../abstract_object'
module AppContainer

class PBXGroup < AbstractObject

  Fields = ['sourceTree',
            'name',
            'children',
            'path']

  def initialize(hash={})
    super(self)
    Fields.each do |attr|
      self.class.send(:attr_accessor,attr)
      instance_variable_set('@'+attr,hash[attr])
    end
  end

end

end