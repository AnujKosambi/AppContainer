require_relative 'file_manager'
require_relative 'pbx_reader'

module AppContainer
  class XCProject
    attr_reader :pathname
    attr_accessor :name
    attr_accessor :project
    attr_reader :pbxReader

    def initialize(path, create_new=false)
      create_new_project if create_new

    end

    public

    def self.open(pathname)
      raise "Project File not found at: #{pathname.to_s}"  unless AppContainer::FileManager.projectExits?(pathname)
      @pathname = pathname
      puts getProjectNameFromPath()
      fetch_pbxproj_file()
      @project = new(@pathname, false)
    end

    private

    def create_new_project()
      puts "Creating #{@name} Project File"
    end

    def self.fetch_pbxproj_file()
      @pbxReader = AppContainer::PBXReader.new(@pathname)
      @pbxReader.fetch()
    end

    def self.getProjectNameFromPath()
      @pathname.dirname.basename
    end
  end
end