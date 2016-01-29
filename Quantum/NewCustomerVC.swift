//
//  NewCustomerVC.swift
//  Quantum
//
//  Created by Michael Bart on 12/1/15.
//  Copyright © 2015 CodeMountain. All rights reserved.
//

import UIKit
import Firebase

class NewCustomerVC: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    var customer: Customer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func attemptSubmit(sender: UIButton!) {
        
        if let firstName = firstNameField.text where firstName != "", let lastName = lastNameField.text where lastName != "", let phoneNumber = phoneField.text where phoneNumber != "", let email = emailField.text where email != "" {
            
            
            let newCustomer = DataService.ds.REF_CUSTOMERS.childByAutoId()
            newCustomer.setValue(["firstName": firstName, "lastName": lastName, "phoneNumber": phoneNumber, "email": email])
            
            let customerID = newCustomer.key
            DataService.ds.setCurrentCustomerID(customerID)
            
//            customer = Customer(firstName: firstName, lastName: lastName, customerID: customerID, phoneNumber: phoneNumber, email: email)
//            
//            CustomersVC.customers.append(customer)
            performSegueWithIdentifier("scanning", sender: nil)
            
        }
    }
    
    @IBAction func backBtnPressed(sender: UIButton!) {
        navigationController?.popViewControllerAnimated(true)
    }
}
