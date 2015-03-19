require_relative 'file_manager'
require 'json'
require 'thread'


module AppContainer
class PBXReader
  attr_reader :pathname
  attr_reader :file
  attr_accessor :root_object
  attr_accessor :content
  attr_accessor :json_pathname
  def initialize(path)
    @pathname = path
    puts @pathname
  end

  def fetch()
    convertToJSON()
    @file = AppContainer::FileManager.read(@json_pathname)
    @content = @file.read
    puts @content
  end

  def convertToJSON()
    output_file = File.join(@pathname.dirname,'project.json')
    command = 'plutil -convert json -r -o '+output_file+' -- '+@pathname.to_s
    thread = Thread.new do
       exec(command)
    end
    @json_pathname = Pathname.new(output_file)
    thread.join()
    raise "project.pbxproj cannot convert to json" unless  AppContainer::FileManager.fileExits?(@json_pathname)
    thread
  end

end
end