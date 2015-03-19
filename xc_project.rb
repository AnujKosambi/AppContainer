require_relative 'file_manager'
require_relative 'pbx_proj_manager'

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
      pbx_
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


  end
end