
require_relative '../file_manager'

module AppContainer
  class PropertyReader
  
    attr_accessor :file
    public
    def self.Open(path)
      @file = AppContainer::FileManager.OpenRead(path)
      @properties = JSON[@file.read]
      puts @properties['APP_NAME']
    end

    def self.Execute

    end


  end
end