//
//  DeviceInfoVC.swift
//  Quantum
//
//  Created by Michael Bart on 12/3/15.
//  Copyright © 2015 CodeMountain. All rights reserved.
//

import UIKit
import Firebase

class DeviceInfoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var deviceIDs = [String]()
    var devices = [Device]()
    var currentDeviceKey: String!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.automaticallyAdjustsScrollViewInsets = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 155
        
        DataService.ds.REF_CUSTOMERS.childByAppendingPath("\(DataService.ds.currentCustomerID)").childByAppendingPath("devices").observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            
            self.deviceIDs = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    if let deviceExist = snap.value as? Int where deviceExist == 1 {
                        // print(snap.key)
                        self.deviceIDs.append(snap.key)
                    }
                }
            }
            
            for id in self.deviceIDs {
                DataService.ds.REF_DEVICES.childByAppendingPath(id).observeEventType(.Value, withBlock: { snapshot in
                    
                    if let deviceDict = snapshot.value as? Dictionary<String, AnyObject> {
                        let key = snapshot.key
                        let device = Device(deviceKey: key, dictionary: deviceDict)
                        self.devices.append(device)
                    }
                    self.tableView.reloadData()
                })
                
            }
            
            self.tableView.reloadData()
            
        })
        self.tableView.tableFooterView = UIView()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let device = devices[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("DeviceCell") as? DeviceCell {
            if device.deviceKey == currentDeviceKey {
                cell.setCurrentLabel()
            }
            cell.configureCell(device)
            
            return cell
        } else {
            return DeviceCell()
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("deviceDetail", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "deviceInfo" {
            if let destinationVC = segue.destinationViewController as? SailDetailsVC {
                destinationVC.currentDeviceKey = self.currentDeviceKey
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backBtnPressed(sender: UIButton!) {
        navigationController?.popToRootViewControllerAnimated(true)
    }

}
