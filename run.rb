require_relative 'xc_project'
require 'cocoapods'
require 'pathname'

require_relative 'PropertyFile/property_reader'
require_relative 'ExternalLibs/external_libs'

class Run
  attr_accessor :main_project
  attr_accessor :main_project_path
  attr_accessor :scheme_name
  def self.run
    puts "------------------------------------------------------------------------"
    if ARGV.length != 2
      puts "Usages: <Path_To_.xcodeproj> <Scheme>"
      exit(-1)
    end

    @main_project_path = ARGV[0]
    @scheme_name = ARGV[1]
    AppContainer::PropertyReader.Open('Property.spr')
    full_dir_path = File.join(@main_project_path,@scheme_name+".xcodeproj")
    project = AppContainer::XCProject.open(Pathname.new(full_dir_path),create:true)
    #project.add_new_group('/Test/ANUJ/P/KOSAMBI',create: true)
    #project.addAppIcons("Images","Sprinklr",".")
    project.save
  end

end

Run.run