#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ble_plugin_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'ble_plugin_flutter'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
Bluetooth plugin for jHealthSDK.
                       DESC
  s.homepage         = 'https://github.com/cnduongdev/ble_plugin_flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'duongcndev' => 'duongcn.dev@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  s.vendored_libraries = 'Classes/libBleSDK.a', 'Classes/libNSKAlgoSDKECG.a', 'StreamSDK.a'

end
