import 'package:flutter_test/flutter_test.dart';
import 'package:ble_plugin_flutter/ble_plugin_flutter.dart';
import 'package:ble_plugin_flutter/ble_plugin_flutter_platform_interface.dart';
import 'package:ble_plugin_flutter/ble_plugin_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBlePluginFlutterPlatform
    with MockPlatformInterfaceMixin
    implements BlePluginFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BlePluginFlutterPlatform initialPlatform = BlePluginFlutterPlatform.instance;

  test('$MethodChannelBlePluginFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBlePluginFlutter>());
  });

  test('getPlatformVersion', () async {
    BlePluginFlutter blePluginFlutterPlugin = BlePluginFlutter();
    MockBlePluginFlutterPlatform fakePlatform = MockBlePluginFlutterPlatform();
    BlePluginFlutterPlatform.instance = fakePlatform;

    expect(await blePluginFlutterPlugin.getPlatformVersion(), '42');
  });
}
