//
//  Customer.swift
//  Quantum
//
//  Created by Michael Bart on 12/1/15.
//  Copyright © 2015 CodeMountain. All rights reserved.
//

import Foundation
import Firebase

class Customer {
    
    private var _firstName: String!
    private var _lastName: String!
    private var _email: String?
    private var _phoneNumber: String!
    //private var _devices: [Device]
    private var _customerKey: String!
    private var _customerRef: Firebase!
    
    var firstName: String! {
        return _firstName
    }
    
    var lastName: String! {
        return _lastName
    }
    
    var customerKey: String! {
        return _customerKey
    }
    
//    var devices: [Device] {
//        return _devices
//    }
    
    var phoneNumber: String! {
        return _phoneNumber
    }
    
    var email: String? {
        return _email
    }
    
    init(customerKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._customerKey = customerKey
        
        if let firstName = dictionary["firstName"] as? String {
            self._firstName = firstName
        }
        
        if let lastName = dictionary["lastName"] as? String {
            self._lastName = lastName
        }
        
        if let phoneNumber = dictionary["phoneNumber"] as? String {
            self._phoneNumber = phoneNumber
        }
        
        if let email = dictionary["email"] as? String {
            self._email = email
        }
        
        print(dictionary)
    }

}