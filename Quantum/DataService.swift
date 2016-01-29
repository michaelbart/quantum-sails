//
//  DataService.swift
//  Quantum
//
//  Created by Michael Bart on 12/1/15.
//  Copyright © 2015 CodeMountain. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://quantumsails.firebaseio.com"

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_USERS =  Firebase(url: "\(URL_BASE)/users")
    private var _REF_CUSTOMERS = Firebase(url: "\(URL_BASE)/customers")
    private var _REF_DEVICES = Firebase(url: "\(URL_BASE)/devices")
    
    var currentCustomerID = "-K4dAp2BT5DC_50waL0K"
    var currentDeviceID: String!
    
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    var REF_CUSTOMERS: Firebase {
        return _REF_CUSTOMERS
    }
    
    var REF_DEVICES: Firebase {
        return _REF_DEVICES
    }
    
    var REF_USER_CURRENT: Firebase {
        let uid = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let user = Firebase(url: "\(URL_BASE)/users").childByAppendingPath(uid)
        return user!
    }
    
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>) {
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
    
    func setCurrentCustomerID(customerID: String) {
        currentCustomerID = customerID
    }
    
    func linkDeviceToCurrentCustomer(deviceID: String) {
        currentDeviceID = deviceID
        let device = REF_CUSTOMERS.childByAppendingPath(currentCustomerID).childByAppendingPath("devices").childByAppendingPath(currentDeviceID)
        device.setValue(true)
        
    }
}