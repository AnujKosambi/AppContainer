module AppContainer
class AppIcon

  Icon = Struct.new(:size, :idiom, :scale,:filename)

  def self.CreateStandardIcons
    iconSets = Array.new
    iconSets << Icon.new('29','iphone','1',nil)
    iconSets << Icon.new('29','iphone','2',nil)
    iconSets << Icon.new('29','iphone','3',nil)
    iconSets << Icon.new('40','iphone','2',nil)
    iconSets << Icon.new('40','iphone','3',nil)
    iconSets << Icon.new('57','iphone','1',nil)
    iconSets << Icon.new('57','iphone','2',nil)
    iconSets << Icon.new('60','iphone','2',nil)
    iconSets << Icon.new('60','iphone','3',nil)
    iconSets
  end

  def self.GetHash(iconStruct)
    hash = {
        "size" => "#{iconStruct.size}x#{iconStruct.size}",
        "idiom" => iconStruct.idiom,
        "scale" => iconStruct.scale+"x"
    }
    hash["filename"] = iconStruct.filename if iconStruct.filename
    hash
  end

end
end