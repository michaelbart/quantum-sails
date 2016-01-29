//
//  DeviceScanVC.swift
//  Quantum
//
//  Created by Michael Bart on 12/3/15.
//  Copyright © 2015 CodeMountain. All rights reserved.
//

import UIKit

class DeviceScanVC: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var scanBtn: MaterialButton!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    var currentDeviceKey: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func startActivity(label: String) {
        self.instructionsLabel.hidden = true
        self.scanBtn.hidden = true
        self.activityLabel.text = label
        self.activityLabel.hidden = false
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
    }
    
    func endActivity() {
        self.instructionsLabel.hidden = false
        self.scanBtn.hidden = false
        self.activityLabel.hidden = true
        self.activityIndicator.hidden = true
        self.activityIndicator.stopAnimating()
    }
    
    @IBAction func scanBtnPressed(sender: AnyObject) {
        startActivity("Scanning for device...")
        
        let newDevice = DataService.ds.REF_DEVICES.childByAutoId()
        newDevice.setValue(["UUID": "38fhrjt5-2j3h-9djf-2k3j-029jfng3",
                            "addressBTLE": "11:14:08:10:BB:DC",
                            "serialNumber": "AA-000002",
                            "lastConnection": "2015/01/22",
                            "batteryLevel": 0.93,
                            "customerID": "",
                            "sailDetails":[
                                "serialNumber": "BB-111111",
                                "model":"Mach 1",
                                "type":"Furling Jib",
                                "dateOfLastService":"2015/02/23",
                                "dateOfManufacture":"2014/03/12"]
                            ])
        
        // If customerID is "" then link to current customer (new device)
        // If customerID has a value, findCustomer based on value
        self.currentDeviceKey = newDevice.key
        DataService.ds.linkDeviceToCurrentCustomer(newDevice.key)
        

        
//        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 4 * Int64(NSEC_PER_SEC))
//        dispatch_after(time, dispatch_get_main_queue()) {
//            self.startActivity("Device found!")
//            self.activityIndicator.hidden = true
//        }
//        let time2 = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 5 * Int64(NSEC_PER_SEC))
//        dispatch_after(time2, dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("deviceInfo", sender: nil)
//        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "deviceInfo" {
            if let destinationVC = segue.destinationViewController as? DeviceInfoVC {
                destinationVC.currentDeviceKey = self.currentDeviceKey
            }
        }
    }
    @IBAction func backBtnPressed(sender: UIButton!) {
        navigationController?.popToRootViewControllerAnimated(true)
    }

}
