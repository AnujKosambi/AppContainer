require 'securerandom'
require 'uri'

require_relative 'file_manager'
require_relative 'pbx_project_manager'

require_relative 'Components/PBXClasses/pbx_class'
require_relative 'Components/BuildSettings/xc_build_configuration'
require_relative 'constants'
require_relative 'app_icon'


module AppContainer
  class XCProject

    attr_reader :pathname
    attr_reader :projectManager

    attr_accessor :name


    def initialize(path, create_new=false)
      create_new_project if create_new
      @pathname = path
      @icon_content = Hash.new
    end


    public

    def changeAppIcon(url,target="")
      uri = URI.parse(url)
      prepareIcons('Images','AppIcons')
    end

    def prepareIcons(xcassets, iconSetName)
      name = xcassets + '.xcassets'
      path = './Test'
      iconFolder = iconSetName + '.appiconset'

      AppContainer::FileManager.TouchDir(path, name)
      AppContainer::FileManager.TouchDir(path, name, iconFolder)

      contentIconArray = AppContainer::AppIcon.CreateStandardIcons

      @icon_content['images'] = Array.new

      for i in 0...contentIconArray.count do
        iconObj = contentIconArray[i]
        if (i == 7)
          iconObj.filename = "yahoo_messenger_120.png"
        end
        @icon_content['images'] << AppIcon.GetHash(iconObj)
      end

      @icon_content['info'] = { 'version' => 1 ,'author' => 'xcode' }

      AppContainer::FileManager.CreateFile(File.join(path,name,iconFolder,'Contents.json'),@icon_content.to_json)
      uuid = add_file(Pathname.new('./Test/'+name),"/Test")

      @projectManager.XCBuildConfigurations.each do |key,config|
        config.ASSETCATALOG_COMPILER_APPICON_NAME = iconSetName
      end

      add_build_file(uuid,'Test',AppContainer::BuildPhases.TYPES.sources)

    end

    def self.open(pathname)
      raise "AppContainer::Project File not found at: #{pathname.to_s}"  unless AppContainer::FileManager.projectExits?(pathname)
      project = new(pathname, false)
      puts project.getProjectNameFromPath
      project.parse_pbxproj_file
      project
    end

    def add_file(filepath,groupPath, sourceTree = "<group>",createGroups: true)
      #To Do file Exits or Not
      pbxfile = prepareFileReference(filepath,sourceTree)
      uuid = generateUUID4
      @projectManager.PBXFileReferences[uuid] = pbxfile
      group = find_group_by_name(groupPath)
      if group
        group = group[:obj]
      elsif createGroups #to do reduce find methods
              group = add_new_group(groupPath,create:true)
      else
             raise "AppContainer::Group Not Found #{groupPath}"
      end
      group.children << uuid
      uuid
     # TO DO adding build file
    end

    def add_file_to_group(filePath,group, sourceTree = "<group>")
      prepareFileReference(filePath,sourceTree)
      uuid = generateUUID4
      @projectManager.PBXFileReferences[uuid] = pbxfile
      group.children << uuid
    end

    def add_build_file(fileRef,target,type) #To Do  Check file action and source resource and framework
      pbx_buildfile = AppContainer::PBXBuildFile.new
      pbx_buildfile.fileRef = fileRef
      uuid = generateUUID4
      @projectManager.PBXBuildFiles[uuid] = pbx_buildfile
      pbx_buildfile.settings = $BUILD_FILE_OPTIONAL
      target = find_target(target)
      buildPhases =  target.method(type).call
      buildPhases.files << uuid
    end

    def find_group_by_name(groupPath,giveLastMatched=false) #to DO check by Path
      currentGroupID = @projectManager.PBXProjectSection.mainGroup
      currentGroup = @projectManager.groups[currentGroupID]
      paths = groupPath.scan(/[\w'-]+/)
      groupID = 0
      parentID = 0
      foundPath = ""
      if paths.count == 0
        return {:path => foundPath, :obj => currentGroup }
      end
      for i in 0...paths.count
        isMatches = false
        currentGroup.children.each do |value|
          if @projectManager.groups[value] != nil
            if @projectManager.groups[value].name == paths[i] || @projectManager.groups[value].path == paths[i]
              currentGroupID = value
              currentGroup = @projectManager.groups[currentGroupID]
              isMatches = true
              foundPath += "/" + paths[i]
              break
            end
          end
        end
        return nil if isMatches == false &&  giveLastMatched == false
        return {:path => foundPath, :obj => currentGroup } if i+1 == paths.count
      end
    end

    def add_new_group(group_name,create: false,sourceTree: "<group>")
      findObj = find_group_by_name(group_name,true);
      parent_pbxgroup = findObj[:obj]

      unless create
        raise "AppContainer::Parent Group Not Found" if findObj[:path].scan(/[\w'-]+/).count != group_name.scan(/[\w'-]+/).count
      else
        donePath = findObj[:path]
        remaining = group_name.scan(/[\w'-]+/) - donePath.scan(/[\w'-]+/)
        remaining.each do |current|
           parent_pbxgroup = add_new_group_to_pbxparent(current,parent_pbxgroup,sourceTree)
        end
      end
      parent_pbxgroup
    end

    def add_new_group_to_pbxparent(group_name,parentGroup = nil,sourceTree = "<group>")
      if(parentGroup == nil)
        parentGroup = @projectManager.groups[@projectManager.PBXProjectSection.mainGroup]
      end
      newUUID = generateUUID4
      parentGroup.children << newUUID
      pbxGroup = AppContainer::PBXGroup.new
      pbxGroup.name = group_name  #to do for check name of path
      pbxGroup.sourceTree = sourceTree
      pbxGroup.children = Array.new
      @projectManager.groups[newUUID] = pbxGroup
    end

    def save
      @projectManager.updateAllPBXObject
      temp_file = File.join("#{@pathname.dirname}","temp_project.json")
      AppContainer::FileManager.CreateFile(temp_file,@projectManager.allObjects.to_json)
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

    private

    def find_target(name)
      target = nil
      @projectManager.targets.each do |key,value|
        if value.root.name == name
          target = @projectManager.targets[key]
        end
      end
      target
    end

    def prepareFileReference(filePath, sourceTree)
      raise "AppContainer::File not found at: #{filePath.to_s}" \
                unless AppContainer::FileManager.dirExists?(filePath) || AppContainer::FileManager.fileExits?(filePath)
      raise "AppContainer::Please Open Project: #{@pathname.basename.to_s}" if @projectManager.nil?

      puts "Adding File..."

      pbxfile = AppContainer::PBXFileReference.new
      pbxfile.lastKnownFileType = getLastKnownFileName(filePath)
      pbxfile.path = filePath.basename.to_s
      pbxfile.sourceTree = sourceTree
      pbxfile
    end

    def getLastKnownFileName(filePath)
     $FILE_TYPES_BY_EXTENSION[filePath.to_s.split('.')[-1]]
    end

    def getRootPathOfGroup(group)
      path = group.name || group.path
    end

    public
    def getProjectNameFromPath
      @pathname.dirname.basename
    end
    private

    def generateUUID4
      uuid = SecureRandom.uuid.to_s
      uuid = uuid.split("-")[1..-1].join().upcase
    end


  end


end