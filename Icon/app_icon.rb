require_relative '../file_manager'
require_relative '../ExternalLibs/external_libs'
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

  def self.GetIconFromSize(size, filename)

    case size
      when 80
        Icon.new('40','iphone','2',filename.basename)
      when 120
        Icon.new('60','iphone','2',filename.basename)
      when 180
        Icon.new('60','iphone','3',filename.basename)
      when 57
        Icon.new('57','iphone','1',filename.basename)
      when 114
        Icon.new('57','iphone','2',filename.basename)
      when 29
        Icon.new('29','iphone','1',filename.basename)
      when 58
        Icon.new('29','iphone','2',filename.basename)
      when 87
        Icon.new('29','iphone','3',filename.basename)
    end
  end

  def self.GetIconSet(pathName)
    iconSets = Array.new
    @folderPathname = pathName
    raise "Folder does Not Exists #{pathName}" unless AppContainer::FileManager.dirExists?(pathName.to_s)
    pngFiles =  Dir[File.join(@folderPathname.to_s,'*.*')].select{ |i| i[/\.png?$/i] }

    pngFiles.each do |file|
      size = GetImageSize.GetDimensions(file)[0]
      iconSets << GetIconFromSize(size,Pathname.new(file))
    end
    iconSets
  end

end
end