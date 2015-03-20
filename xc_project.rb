require 'securerandom'
require_relative 'file_manager'
require_relative 'pbx_project_manager'
require_relative 'PBXClasses/pbx_file_reference'
require_relative 'PBXClasses/pbx_group'

module AppContainer
  class XCProject

    attr_reader :pathname
    attr_reader :projectManager

    attr_accessor :name

    def initialize(path, create_new=false)
      create_new_project if create_new
      @pathname = path
    end

    public

    def self.open(pathname)
      raise "AppContainer::Project File not found at: #{pathname.to_s}"  unless AppContainer::FileManager.projectExits?(pathname)
      project = new(pathname, false)
      puts project.getProjectNameFromPath
      project.parse_pbxproj_file
      project
    end


    def add_file(filepath, sourceTree = "<group>")
      #To Do file Exits or Not
      raise "AppContainer::File not found at: #{filepath.to_s}" unless AppContainer::FileManager.fileExits?(filepath)
      raise "AppContainer::Please Open Project: #{@pathname.basename.to_s}" if @projectManager.nil?

      puts "Adding File..."

      pbxfile = AppContainer::PBXFileReference.new
      pbxfile.lastKnownFileType = 'sourcecode.c.objc' #TO DO

      pbxfile.path = filepath.basename.to_s
      pbxfile.sourceTree = sourceTree

      uuid = generateUUID4
      @projectManager.PBXFileReferences[uuid] = pbxfile

      group = find_group_by_name("Test")
      group.children << uuid

      file_hash=pbxfile.generateHash
      @projectManager.objects[uuid] = file_hash
    end

    def find_group_by_name(groupName) #to DO check by Path
      groupID = 0
      @projectManager.groups.each do |key,value|
          if value.name == groupName || value.path == groupName
            groupID = key
            break
          end
      end
      return @projectManager.groups[groupID] if groupID != 0
      return nil
    end

    def add_new_group(group_name,parentGroup_name = "",sourceTree = "<group>")

      parent_pbxgroup = find_group_by_name(parentGroup_name)

      unless(parent_pbxgroup)
        parent_pbxgroup = @projectManager.groups[@projectManager.PBXProjectSection.mainGroup]
      end

      newUUID = generateUUID4
      parent_pbxgroup.children << newUUID

      pbxGroup = AppContainer::PBXGroup.new
      pbxGroup.name = group_name
      pbxGroup.sourceTree = sourceTree
      @projectManager.groups[newUUID] = pbxGroup
    end

    def save
      @projectManager.updateAllPBXObject

      puts @projectManager.allObjects
      temp_file = File.join("#{@pathname.dirname}","temp_project.json")
      file = File.new(temp_file,"w")
      file.puts(@projectManager.allObjects.to_json)
      file.close
      command = 'plutil -convert xml1  -o ' + @pathname.to_s + ' -- '+temp_file
      AppContainer::FileManager.PerformCommand(command)

    end

    def create_new_project
      puts "Creating #{@name} Project File"
    end

    def parse_pbxproj_file
      @projectManager = AppContainer::PBXProjectManager.new(@pathname)
      @projectManager.fetch
    end


=begin ++++++++++++++++++++++++++++++++++++Helpers +++++++++++++++++++++++++++++++++++++++
=end

    def getProjectNameFromPath
      @pathname.dirname.basename
    end

    def generateUUID4
      uuid = SecureRandom.uuid.to_s
      uuid = uuid.split("-")[1..-1].join().upcase
    end

  end
end