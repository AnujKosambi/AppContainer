require_relative 'file_manager'
require 'rubygems'
require 'json'
require 'thread'


module AppContainer
class PBXProjManager
  attr_reader :pathname
  attr_reader :file
  attr_accessor :content

  attr_accessor :root_object
  attr_accessor :json_pathname
  attr_accessor :archiveVersion
  attr_accessor :classes
  attr_accessor :objectVersion
  attr_accessor :objects
  attr_accessor :rootObject
  attr_accessor :allObjects


  def initialize(path)
    @pathname = path
    puts @pathname
  end

  def fetch()
    convertToJSON()
    @file = AppContainer::FileManager.read(@json_pathname)
    @content = @file.read()
    hash = JSON[@content]
    @rootObject = hash['rootObject']
    @objects = hash['objects']
    @objectVersion = hash['objectVersion']
    @classes = hash['classes']
    @archiveVersion = hash['archiveVersion']
    @allObjects = hash
  end

  def convertToJSON()
    output_file = File.join(@pathname.dirname,'project.json')
    command = 'plutil -convert json -r -o '+output_file+' -- '+@pathname.to_s
    thread = Thread.new do
      %x(#{command})
    end
    @json_pathname = Pathname.new(output_file)
    thread.join()
    raise "AppContainer::project.pbxproj is not  converted toJSON successfully" unless  AppContainer::FileManager.fileExits?(@json_pathname)
    thread
  end

end
end