#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ble_plugin_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'ble_plugin_flutter'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*', '**/*.h'
  s.public_header_files = '**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  # s.script_phase = {
  #   :name => 'ble_plugin_flutter',
  #   :script => 'FLUTTER_ROOT=$(which flutter | xargs dirname | xargs dirname); cd $FLUTTER_ROOT; flutter build ios --no-codesign',
  #   :execution_position => :after_compile,
  #   :input_files => [],
  #   :output_files => ['ios/ble_plugin_flutter-Bridging-Header.h']
  # }

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386', 'SWIFT_OBJC_BRIDGING_HEADER' => 'ios/ble_plugin_flutter-Bridging-Header.h' }
  #  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386', 'SWIFT_OBJC_BRIDGING_HEADER' => 'ios/ble_plugin_flutter-Bridging-Header.h' }

  s.swift_version = '5.0'
  
end
