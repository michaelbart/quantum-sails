//
//  Device.swift
//  Quantum
//
//  Created by Michael Bart on 12/1/15.
//  Copyright © 2015 CodeMountain. All rights reserved.
//

import Foundation
import Firebase

class Device {
    
    private var _UUID: String!
    private var _addressBTLE: String!
    private var _batteryLevel: Float!
    private var _lastConnection: String!
    private var _serialNumber: String!
    private var _deviceKey: String!
    private var _deviceRef: Firebase!
    private var _sailDetails: Dictionary<String, AnyObject>!
    private var _sailType: String!
    var currentDevice = false
    
    var UUID: String! {
        return _UUID
    }
    
    var sailType: String! {
        return _sailType
    }
    
    var addressBTLE: String! {
        return _addressBTLE
    }
    
    var batteryLevel: Float! {
        return _batteryLevel
    }
    
    var lastConnection: String! {
        return _lastConnection
    }
    
    var serialNumber: String! {
        return _serialNumber
    }
    
    var deviceKey: String! {
        return _deviceKey
    }
    
    var sailDetails: Dictionary<String, AnyObject>! {
        return _sailDetails
    }
    
    init(deviceKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._deviceKey = deviceKey
        
        if let UUID = dictionary["UUID"] as? String {
            self._UUID = UUID
        }
        
        if let addressBTLE = dictionary["addressBTLE"] as? String {
            self._addressBTLE = addressBTLE
        }
        
        if let batteryLevel = dictionary["batteryLevel"] as? Float {
            self._batteryLevel = batteryLevel
        }
        
        if let lastConnection = dictionary["lastConnection"] as? String {
            self._lastConnection = lastConnection
        }
        
        if let serialNumber = dictionary["serialNumber"] as? String {
            self._serialNumber = serialNumber
        }
        print(dictionary)
        if let sailDetails = dictionary["sailDetails"] as? Dictionary<String, AnyObject> {
            self._sailDetails = sailDetails
            if let sailType = sailDetails["type"] {
                self._sailType = sailType as? String
            }
        }
        
        self._deviceRef = DataService.ds.REF_DEVICES.childByAppendingPath(self._deviceKey)
        
        if self._deviceRef == DataService.ds.currentDeviceID {
            self.currentDevice = true
        } else {
            self.currentDevice = false
        }
    }

    
}