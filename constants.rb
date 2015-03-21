module AppContainer
class Constants
  FILE_TYPES_BY_EXTENSION = {
      'a'           => 'archive.ar',
      'app'         => 'wrapper.application',
      'bundle'      => 'wrapper.plug-in',
      'dylib'       => 'compiled.mach-o.dylib',
      'framework'   => 'wrapper.framework',
      'h'           => 'sourcecode.c.h',
      'm'           => 'sourcecode.c.objc',
      'markdown'    => 'text',
      'mdimporter'  => 'wrapper.cfbundle',
      'octest'      => 'wrapper.cfbundle',
      'pch'         => 'sourcecode.c.h',
      'plist'       => 'text.plist.xml',
      'sh'          => 'text.script.sh',
      'swift'       => 'sourcecode.swift',
      'xcassets'    => 'folder.assetcatalog',
      'xcconfig'    => 'text.xcconfig',
      'xcdatamodel' => 'wrapper.xcdatamodel',
      'xcodeproj'   => 'wrapper.pb-project',
      'xctest'      => 'wrapper.cfbundle',
      'xib'         => 'file.xib',
  }.freeze

  HEADER_FILES_EXTENSIONS = %w(.h .hh .hpp .ipp).freeze

end
end