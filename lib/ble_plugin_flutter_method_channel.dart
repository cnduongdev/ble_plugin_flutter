import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ble_plugin_flutter_platform_interface.dart';

/// An implementation of [BlePluginFlutterPlatform] that uses method channels.
class MethodChannelBlePluginFlutter extends BlePluginFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ble_plugin_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
