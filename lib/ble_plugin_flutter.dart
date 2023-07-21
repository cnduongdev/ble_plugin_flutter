
import 'ble_plugin_flutter_platform_interface.dart';

class BlePluginFlutter {
  Future<String?> getPlatformVersion() {
    return BlePluginFlutterPlatform.instance.getPlatformVersion();
  }

  Future<void> scanBleDevices() {
    return BlePluginFlutterPlatform.instance.scanBleDevices();
  }
}
