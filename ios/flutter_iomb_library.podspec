#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_iomb_library.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_iomb_library'
  s.version          = '1.0.0'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Frank Hinkel' => 'example@mail.me' }
  s.source           = { :path => '.' }
  s.platform = :ios, '11.0'

  # Implement flutter as subspec
  s.subspec 'Flutter' do |flutter|
    flutter.dependency 'Flutter'
    flutter.source_files = 'Classes/**/*'
  end

  # And then add library as subspec
  s.subspec 'IOMbLibrary' do |iOMbLibrary|
    iOMbLibrary.dependency 'IOMbLibrary'
    iOMbLibrary.source_files = '../IOMbLibrary'
  end

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end