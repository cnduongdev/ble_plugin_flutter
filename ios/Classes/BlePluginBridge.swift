//
//  BlePluginBridge.swift
//  ble_plugin_flutter
//
//  Created by Apple on 20/07/2023.
//

import Foundation
import CoreBluetooth


class BlePluginBride {
    
    static var shared = BlePluginBride()
    var ble = BlePluginHelper()

    var callBack: ((CBPeripheral) -> Void)?
    func setUpCentralManager() {
        ble.bleDelegate = self
        ble.setUpCentralManager()
    }
    
    
    func scanBleDevices() {
        ble.scanDevice()
    }
    
    func stopScan() {
        ble.stopScan()
    }
    
    func connectToDevice(periphecal: CBPeripheral) {
        ble.connectDeviceName(periphecal)
    }

}

extension BlePluginBride: BlePluginHelperDelegate {
    func `return`(_ completionScanPeripheral: CBPeripheral!) {
        if let `callBack` = self.callBack {
            callBack(completionScanPeripheral)
        }
    }
    
    func returnPeripheral( completionScanPeripheral: CBPeripheral!) {
       
    }
}
