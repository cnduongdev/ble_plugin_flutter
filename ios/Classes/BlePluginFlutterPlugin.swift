import Flutter
import UIKit

public class BlePluginFlutterPlugin: NSObject, FlutterPlugin {
    
    var channel: FlutterMethodChannel!
    
    static var bluetoothDevices : [CBPeripheral] = []
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let blechannel = FlutterMethodChannel(name: "ble_plugin_flutter", binaryMessenger: registrar.messenger())
        let instance = BlePluginFlutterPlugin()
        baseConfiguration()
        registrar.addMethodCallDelegate(instance, channel: blechannel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "scan_ble_devices":
            BlePluginFlutterPlugin.baseConfiguration()
            self.scanBleDevices()
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func scanBleDevices() {
        BlePluginBride.shared.scanBleDevices()
    }

    func stopScanBleDevices(result: FlutterResult) {
        BlePluginBride.shared.stopScan()
    }

    func connectToDevice(deviceName: String) {
        if let periphecal = BlePluginFlutterPlugin.bluetoothDevices.first(where: { ($0.name ?? "") == deviceName }) {
            BlePluginBride.shared.connectToDevice(periphecal: periphecal)
        }
    }

    public static func baseConfiguration() {
        BlePluginBride.shared.callBack = { pheriphcal in
                print("Đã bắt được tín hiệu của \(pheriphcal.name ?? "")")
            if (BlePluginFlutterPlugin.bluetoothDevices.firstIndex(of: pheriphcal) == nil) {
                BlePluginFlutterPlugin.bluetoothDevices.append(pheriphcal)
                //self.channel.invokeMethod("element", arguments: pheriphcal.name ?? "Unknowed")

            }

        }
    }

}
