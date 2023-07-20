import Flutter
import UIKit

public class BlePluginFlutterPlugin: NSObject, FlutterPlugin {
    
    var channel: FlutterMethodChannel!
    
    var bluetoothDevices : [CBPeripheral] = []
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let blechannel = FlutterMethodChannel(name: "ble_plugin_flutter", binaryMessenger: registrar.messenger())
        let instance = BlePluginFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: blechannel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "scan_ble_devices":
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
        if let periphecal = self.bluetoothDevices.first(where: { ($0.name ?? "") == deviceName }) {
            BlePluginBride.shared.connectToDevice(periphecal: periphecal)
        }
    }
    
    public func baseConfiguration() {
        BlePluginBride.shared.setUpCentralManager()
        BlePluginBride.shared.callBack = { [weak self] pheriphcal in
            guard let `self` = self else { return }
            //    print("Đã bắt được tín hiệu của \(pheriphcal.name ?? "")")
            if (self.bluetoothDevices.firstIndex(of: pheriphcal) == nil) {
                self.bluetoothDevices.append(pheriphcal)
                //self.channel.invokeMethod("element", arguments: pheriphcal.name ?? "Unknowed")
                
            }
            
        }
    }
    
}
