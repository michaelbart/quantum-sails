//
//  SailDetailsVC.swift
//  Quantum
//
//  Created by Michael Bart on 12/10/15.
//  Copyright © 2015 CodeMountain. All rights reserved.
//

import UIKit


class SailDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var topMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var chooseTypeBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var darkenView: UIView!
    @IBOutlet weak var additionalMenu: MaterialView!
    @IBOutlet weak var repairBtn: UIButton!
    
    var sailType: String!
    var sailModel: String!
    var lastServiceDate: String!
    var manufactureDate: String!
    var buttonPressed: String!
    var enteringEvent = false
    var pickingType = false
    var currentDeviceKey: String!
    

    
    let sailTypes = ["Mast Furled Main","Boom Furled Main","Conventional Main","Traditional Jib","Traditional Genoa","Stormsail","Trisail","Furling Jib","Furling Genoa","Furling Code Zero","Mizen","Asym Spinakker","Sym Spinakker"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //additionalMenu.hidden = true
        //additionalMenu.alpha = 0
        //self.additionalMenu.center.y = 600
        darkenView.alpha = 0
        //darkenView.hidden = true
        tableView.alpha = 0
        tableView.hidden = true
        tableView.delegate = self
        tableView.dataSource = self
        additionalMenu.alpha = 0
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "eventEntry" {
            if let destinationVC = segue.destinationViewController as? EventEntryVC {
                destinationVC.buttonPressed = self.buttonPressed
            }
        }
    }

    
    @IBAction func menuBtnPressed(sender: UIButton!) {
        
        
        switch sender.tag {
        case  0:
            buttonPressed = "Repair"
        case 1:
            buttonPressed = "Clean"
        case 2:
            buttonPressed = "Reset"
        case 3:
            buttonPressed = "Cancel"
        case 4:
            buttonPressed = "Returned"
        case 5:
            buttonPressed = "Sale"
        default:
            break
        }
        
    }

    @IBAction func typeBtnPressed(sender: UIButton!) {
        showTable()
        if self.enteringEvent == true {
            hideAdditionalMenu()
        }
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let type = sailTypes[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) 
        cell.textLabel?.text = type
        cell.textLabel?.font = UIFont(name: "Open Sans", size: 17)
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        cell.textLabel?.highlightedTextColor = UIColor.whiteColor()
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 21/255, green: 173/255, blue: 160/255, alpha: 1)
        cell.selectedBackgroundView = backgroundView
        
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let selectedType = sailTypes[indexPath.row]
        chooseTypeBtn.setTitle(selectedType, forState: UIControlState.Normal)
        hideTable()
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sailTypes.count
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        hideTable()
        hideAdditionalMenu()
    }
    
    func hideTable() {
        pickingType = false
        UIView.animateWithDuration(0.3, animations: {
            self.tableView.alpha = 0
            self.darkenView.alpha = 0
           // self.darkenView.hidden = true
           // self.tableView.hidden = true
        })
        
    }
    func showTable() {
        pickingType = true
        //darkenView.hidden = false
        tableView.hidden = false
        UIView.animateWithDuration(0.3, animations: {
            self.tableView.alpha = 1
            self.darkenView.alpha = 0.3
        })
    }
    
    func showAdditionalMenu() {
        //darkenView.hidden = false
        enteringEvent = true
        UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseInOut, animations: {
            //self.darkenView.alpha = 0.3
            self.topMenuConstraint.constant = 0
            self.additionalMenu.alpha = 1
            self.additionalMenu.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func hideAdditionalMenu() {
        enteringEvent = false
        //darkenView.hidden = true
        
        UIView.animateWithDuration(0.2, animations: {
            //self.additionalMenu.alpha = 0
            self.topMenuConstraint.constant = 246
            
            self.additionalMenu.layoutIfNeeded()
            self.additionalMenu.alpha = 0
            //self.darkenView.alpha = 0
        })
        
        
    }
    
    @IBAction func backBtnPressed(sender: UIButton!) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func enterEvent(sender:UIButton!) {
        
        showAdditionalMenu()
        if pickingType == true {
            hideTable()
        }
    }

}
