//
//  CustomerCell.swift
//  Quantum
//
//  Created by Michael Bart on 1/9/16.
//  Copyright © 2016 CodeMountain. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class CustomerCell: UITableViewCell {

    var customer: Customer!
//    @IBOutlet weak var firstName: UILabel!
//    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var fullName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(customer: Customer) {
        self.customer = customer
        self.fullName.text = "\(customer.firstName) \(customer.lastName)"
//        self.firstName.text = customer.firstName
//        self.lastName.text = customer.lastName
        self.email.text = customer.email
        self.phoneNumber.text = customer.phoneNumber
        
    }

}
