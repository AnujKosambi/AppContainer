require_relative 'pbx_native_target'
require_relative 'pbx_sources_build_phase'
require_relative 'pbx_resources_build_phase'
require_relative 'pbx_frameworks_build_phase'

module AppContainer
  class PBXTarget

    attr_accessor :sourcesBuildPhases
    attr_accessor :frameworksBuildPhases
    attr_accessor :resourcesBuildPhases

    attr_accessor :generateHash

    attr_accessor :addSourcesBuildPhases
    attr_accessor :addFrameworkBuildPhases
    attr_accessor :addResourcesBuildPhases
    attr_accessor :root


    def initialize(key,targetHash={})
      @key = key
      @root = PBXNativeTarget.new(targetHash)
    end

    def addSourcesBuildPhases(key,sourcesBuildHash)
      @sourcesBuildPhases = PBXSourcesBuildPhase.new(sourcesBuildHash)
      @sourcesKey = key
    end

    def addFrameworkBuildPhases(key,frameworksBuildHash)
      @frameworkBuildPhases = PBXFrameworksBuildPhase.new(frameworksBuildHash)
      @frameworkKey = key
    end

    def addResourcesBuildPhases(key,resourcesBuildHash)
      @resourcesBuildPhases = PBXResourcesBuildPhase.new(resourcesBuildHash)
      @resourcesKey = key

    end


    def generateHash
      raise "Set All Build Phases" if (@sourcesBuildPhases == nil || @frameworkBuildPhases == nil || @resourcesBuildPhases == nil)
      hash = Hash.new
      hash.merge!({@key => @root.generateHash})
      hash.merge!({@sourcesKey => @sourcesBuildPhases.generateHash})
      hash.merge!({@resourcesKey => @resourcesBuildPhases.generateHash})
      hash.merge!({@frameworkKey => @frameworkBuildPhases.generateHash})
      hash
    end

  end
end