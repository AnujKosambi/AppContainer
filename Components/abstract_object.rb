

module AppContainer

class AbstractObject

  attr_accessor :isa

  def initialize(_class,options={})
    @isa = _class.class.name.to_s.split("::")[-1]
    fields = options[:Fields]
    hash = options[:Hash]
    if fields
    fields.each do |attr|
      _class.class.send(:attr_accessor,attr)
      instance_variable_set('@'+attr,hash[attr])
    end
    end
  end

  def generateHash
    hash = Hash.new()
    instance_variables.each do |variable|
      x = variable.to_s[1..-1]
      value = instance_variable_get(variable)
      ( hash[x] = value ) unless value.nil?
    end
    hash
  end

end
end