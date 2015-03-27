require_relative '../abstract_object'
module AppContainer

class PBXGroup < AbstractObject

  Fields = ['sourceTree',
            'name',
            'children',
            'path']

  def initialize(hash={})
    super(self,{:Fields => Fields,:Hash => hash})
  end

end

end