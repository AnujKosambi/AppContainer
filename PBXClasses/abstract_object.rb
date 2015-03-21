

module AppContainer

class AbstractObject

  attr_accessor :isa

  def initialize(_class)
    @isa = _class.class.name.to_s.split("::")[-1]
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