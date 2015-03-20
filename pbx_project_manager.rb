require_relative 'file_manager'
require 'rubygems'

require_relative 'PBXClasses/pbx_project'
require_relative 'PBXClasses/pbx_file_reference'

module AppContainer
class PBXProjectManager

  attr_reader :pathname
  attr_reader :file
  attr_reader :archiveVersion
  attr_reader :classes
  attr_reader :objectVersion

  attr_accessor :PBXProjectSection
  attr_accessor :PBXFileReferences
  attr_accessor :groups
  attr_accessor :otherObjects
  attr_accessor :root_object

  attr_accessor :objects
  attr_accessor :rootObject
  attr_accessor :allObjects

  attr_accessor :projectUUID

  def initialize(path)
    @pathname = path
    puts @pathname
  end

  def fetch
    convertToJSON
    @file = AppContainer::FileManager.read(@json_pathname)
    @content = @file.read
    hash = JSON[@content]

    @rootObject = hash['rootObject']
    @objects = hash['objects']
    @objectVersion = hash['objectVersion']
    @classes = hash['classes']
    @archiveVersion = hash['archiveVersion']

    @PBXFileReferences  = Hash.new
    @groups = Hash.new
    @otherObjects = Hash.new

    fetchAllPBXObject

    @allObjects = hash

  end

  def convertToJSON
    output_file = File.join(@pathname.dirname,'project.json')
    command = 'plutil -convert json -r -o '+output_file+' -- '+@pathname.to_s
    AppContainer::FileManager.PerformCommand(command)
    @json_pathname = File.new(Pathname.new(output_file))
    raise "AppContainer::project.pbxproj is not  converted toJSON successfully" unless  AppContainer::FileManager.fileExits?(@json_pathname)
  end

  def fetchAllPBXObject

    @objects.each do |key,value|
      case value['isa']
        when "PBXProject"
          @PBXProjectSection = AppContainer::PBXProject.new(value)
          @projectUUID = key
        when "PBXGroup"
          @groups[key] = AppContainer::PBXGroup.new(value)
        when "PBXFileReference"
          @PBXFileReferences[key] = AppContainer::PBXFileReference.new(value)
        else
          @otherObjects[key] = value
      end
    end

  end

  def updateAllPBXObject # To DO optimize

   @objects.clear
   @objects.merge!({@projectUUID => @PBXProjectSection.generateHash})
   @objects.merge!(@groups.reduce({}){ |hash, (k, v)| hash.merge( k => v.generateHash )  })
   @objects.merge!(@PBXFileReferences.reduce({}){ |hash, (k, v)| hash.merge( k => v.generateHash )  })
   @objects.merge!(@otherObjects)


   @allObjects = Hash.new
   @allObjects['rootObject'] = @rootObject
   @allObjects['objects'] = @objects
   @allObjects['objectVersion'] = @objectVersion
   @allObjects['classes'] = @classes
   @allObjects['archiveVersion'] = @archiveVersion
  end



end
end