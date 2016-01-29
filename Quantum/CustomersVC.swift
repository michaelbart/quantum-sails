//
//  CustomersVC.swift
//  Quantum
//
//  Created by Michael Bart on 12/1/15.
//  Copyright © 2015 CodeMountain. All rights reserved.
//

import UIKit
import Firebase

class CustomersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var customerIDs = [String]()
    var customers = [Customer]()
    var currentCustomerKey : String!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_CUSTOMERS.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            
            self.customerIDs = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    self.customerIDs.append(snap.key)
                }
            }
            
            for id in self.customerIDs {
                DataService.ds.REF_CUSTOMERS.childByAppendingPath(id).observeEventType(.Value, withBlock: { snapshot in
                        
                    if let customerDict = snapshot.value as? Dictionary<String, AnyObject> {
                        let key = snapshot.key
                        let customer = Customer(customerKey: key, dictionary: customerDict)
                        self.customers.append(customer)
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
        return customers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let customer = customers[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("CustomerCell") as? CustomerCell {
            cell.configureCell(customer)
            
            return cell
        } else {
            return CustomerCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("customerDetail", sender: self)
        let currentCustomer = customers[indexPath.row]
        currentCustomerKey = currentCustomer.customerKey
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "customersList" {
            if let destinationVC = segue.destinationViewController as? CustomerDetailsVC {
                destinationVC.currentCustomerKey = self.currentCustomerKey
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func backBtnPressed(sender: UIButton!) {
        navigationController?.popViewControllerAnimated(true)
    }
}
