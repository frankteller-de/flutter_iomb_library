Pod::Spec.new do |s|
  s.name = 'flutter_iomb_library'
  s.version = '0.10.0'
  s.summary = 'Flutter integration for the INFOnline census measurement SDK.'
  s.homepage = 'https://github.com/codeforce-dev/flutter_iomb_library'
  s.license = { :file => '../LICENSE' }
  s.author = { 'codeforce-dev' => 'https://github.com/codeforce-dev' }
  s.source = { :path => '.' }
  s.source_files = 'flutter_iomb_library/Sources/flutter_iomb_library/**/*.swift'
  s.dependency 'Flutter'
  s.dependency 'IOMbLibrary', '1.2.0'
  s.platform = :ios, '13.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
