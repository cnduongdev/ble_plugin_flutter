import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ble_plugin_flutter_method_channel.dart';

abstract class BlePluginFlutterPlatform extends PlatformInterface {
  /// Constructs a BlePluginFlutterPlatform.
  BlePluginFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static BlePluginFlutterPlatform _instance = MethodChannelBlePluginFlutter();

  /// The default instance of [BlePluginFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelBlePluginFlutter].
  static BlePluginFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BlePluginFlutterPlatform] when
  /// they register themselves.
  static set instance(BlePluginFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> scanBleDevices() {
    throw UnimplementedError('scanBleDevices() has not been implemented.');
  }
}
