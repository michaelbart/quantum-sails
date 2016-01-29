//
//  DeviceCell.swift
//  Quantum
//
//  Created by Michael Bart on 12/8/15.
//  Copyright © 2015 CodeMountain. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class DeviceCell: UITableViewCell {
    
    var device: Device!
    @IBOutlet weak var lastConnection: UILabel!
    @IBOutlet weak var batteryLevel: UILabel!
    @IBOutlet weak var serialNumber: UILabel!
    @IBOutlet weak var addressBTLE: UILabel!
    @IBOutlet weak var UUID: UILabel!
    @IBOutlet weak var deviceLabel: UILabel!
    @IBOutlet weak var sailType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func configureCell(device: Device) {
        self.device = device
        self.UUID.text = device.UUID
        self.addressBTLE.text = device.addressBTLE
        self.serialNumber.text = device.serialNumber
        let percentBL = device.batteryLevel * 100
        self.batteryLevel.text = "\(percentBL)%"
        self.lastConnection.text = device.lastConnection
        self.sailType.text = device.sailType
        
    }
    func setCurrentLabel() {
        
        self.deviceLabel.text = "Device Details (Current Device)"
    }

}
