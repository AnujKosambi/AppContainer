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

  def self.OpenRead(path)
    File.new(path,'r')
  end

  def self.PerformCommand(command)
    output = ""
    thread = Thread.new do
      output = `#{command}`
    end
    thread.join
    output
  end

  def self.CreateDir(path, *name)
    PerformCommand('mkdir '+File.join(path, name))
  end

  def self.TouchDir(path, *name)
    CreateDir(path, *name) unless dirExists?(File.join(path,name))
  end

  def self.TouchFile(path, *name)
    if name.count > 0
      file = File.new(File.join(path,name),"w+")
    else
      file = File.new(path,"w+")
    end
    file
  end

  def self.CreateFileFromContent(namePath, content)
    file = File.new(namePath,"w+")
    file.puts(content)
    file.close
  end

  def self.DownloadFile(uri,downloadLocation)

  end


end
end