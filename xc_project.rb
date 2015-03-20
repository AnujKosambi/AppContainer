require 'securerandom'
require_relative 'file_manager'
require_relative 'pbx_proj_manager'
require_relative 'PBXClasses/pbx_file_reference'

module AppContainer
  class XCProject

    attr_reader :pathname
    attr_reader :projManager

    attr_accessor :name

    def initialize(path, create_new=false)
      create_new_project if create_new
      @pathname = path
    end

    public

    def self.open(pathname)
      raise "AppContainer::Project File not found at: #{pathname.to_s}"  unless AppContainer::FileManager.projectExits?(pathname)
      project = new(pathname, false)
      puts project.getProjectNameFromPath()
      project.fetch_pbxproj_file
      project
    end


    def add_file(filepath)
      raise "AppContainer::File not found at: #{filepath.to_s}" unless AppContainer::FileManager.fileExits?(filepath)
      raise "AppContainer::Please Open Project: #{@pathname.basename.to_s}" if @projManager.nil?
      puts "Adding File..."

      pbxfile = AppContainer::PBXFileReference.new
      pbxfile.lastKnownFileType='sourcecode.c.objc' #TO DO
      pbxfile.path=filepath.basename.to_s
      pbxfile.sourceTree="<group>"

      uuid=genrateUUID4
      file_hash=pbxfile.generateHash

      @projManager.objects[uuid] = file_hash
      file = File.new(File.join("#{@pathname.dirname}","newproject.json"),"w")
      file.puts(@projManager.allObjects.to_json)
      file.close
    end


    def create_new_project()
      puts "Creating #{@name} Project File"
    end

    def fetch_pbxproj_file()
      @projManager = AppContainer::PBXProjManager.new(@pathname)
      @projManager.fetch
    end


=begin Helper
=end

    def getProjectNameFromPath()
      @pathname.dirname.basename
    end

    def genrateUUID4()
      uuid = SecureRandom.uuid.to_s
      uuid = uuid.split("-")[1..-1].join().upcase
    end

  end
end