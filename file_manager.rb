require 'json'

module AppContainer
class FileManager
  def self.dirExists?(path)
    File.directory?(path)
  end

  def self.fileExits?(path)
    File.file?(path)
  end

  def self.projectExits?(path)
    return false unless self.fileExits?(path.to_s)
    if  /(.*)project.pbxproj/ =~ path.to_s
      return true
    end
    return false
  end

  def self.read(path)
    File.new(path,'r')
  end

  def self.PerformCommand(command)
    thread = Thread.new do
      %x(#{command})
    end
    thread.join
  end

end
end