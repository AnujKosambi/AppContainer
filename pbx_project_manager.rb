require_relative 'file_manager'
require 'rubygems'

require_relative 'PBXClasses/pbx_project'
require_relative 'PBXClasses/pbx_file_reference'
require_relative 'PBXClasses/pbx_build_file'
require_relative 'PBXClasses/pbx_sources_build_phase'
require_relative 'PBXClasses/pbx_native_target'

module AppContainer
class PBXProjectManager

  attr_reader :pathname
  attr_reader :file
  attr_reader :archiveVersion
  attr_reader :classes
  attr_reader :objectVersion

  attr_accessor :PBXProjectSection
  attr_accessor :PBXBuildFiles
  attr_accessor :PBXFileReferences
  attr_accessor :PBXSourcesBuildPhases
  attr_accessor :PBXNativeTargets

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

    @PBXBuildFiles = Hash.new
    @PBXFileReferences  = Hash.new
    @PBXNativeTargets = Hash.new
    @PBXSourcesBuildPhases = Hash.new
    @groups = Hash.new
    @otherObjects = Hash.new

    puts @objects.count
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
        when "PBXBuildFile"
          @PBXBuildFiles[key] = AppContainer::PBXBuildFile.new(value)
        when "PBXProject"
          @PBXProjectSection = AppContainer::PBXProject.new(value)
          @projectUUID = key
        when "PBXGroup"
          @groups[key] = AppContainer::PBXGroup.new(value)
        when "PBXFileReference"
          @PBXFileReferences[key] = AppContainer::PBXFileReference.new(value)
        when "PBXSourcesBuildPhase"
          @PBXSourcesBuildPhases[key] = AppContainer::PBXSourcesBuildPhase.new(value)
        when "PBXNativeTarget"
          @PBXNativeTargets[key] = AppContainer::PBXNativeTarget.new(value)
        else
          @otherObjects[key] = value
      end
    end

  end

  def updateAllPBXObject # To Do optimize

   @objects.clear
   @objects.merge!({@projectUUID => @PBXProjectSection.generateHash})
   @objects.merge!(@PBXBuildFiles.reduce({}){ |hash, (k, v)| hash.merge( k => v.generateHash )  })
   @objects.merge!(@PBXSourcesBuildPhases.reduce({}){ |hash, (k, v)| hash.merge( k => v.generateHash )  })
   @objects.merge!(@PBXNativeTargets.reduce({}){ |hash, (k, v)| hash.merge( k => v.generateHash )  })
   @objects.merge!(@PBXFileReferences.reduce({}){ |hash, (k, v)| hash.merge( k => v.generateHash )  })
   @objects.merge!(@groups.reduce({}){ |hash, (k, v)| hash.merge( k => v.generateHash )  })
   @objects.merge!(@otherObjects)
    puts @objects.count

   @allObjects = Hash.new
   @allObjects['rootObject'] = @rootObject
   @allObjects['objects'] = @objects
   @allObjects['objectVersion'] = @objectVersion
   @allObjects['classes'] = @classes
   @allObjects['archiveVersion'] = @archiveVersion
  end



end
end