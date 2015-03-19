require_relative 'xc_project'
require 'cocoapods'
require 'pathname'

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
    full_access_path = File.join(@main_project_path,@scheme_name+".xcodeproj","project.pbxproj")
    project = AppContainer::XCProject.open(Pathname.new(full_access_path))
    project.add_file(Pathname.new('/Users/anujkosambi/Mobile_Library/Test/Test/ViewController.m'))
  end
end

Run.run