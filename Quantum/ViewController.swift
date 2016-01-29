//
//  ViewController.swift
//  Quantum
//
//  Created by Michael Bart on 12/1/15.
//  Copyright © 2015 CodeMountain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var loginBtn: MaterialButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }

    func startActivity(label: String) {
        self.emailField.hidden = true
        self.passwordField.hidden = true
        self.loginBtn.hidden = true
        self.activityLabel.text = label
        self.activityLabel.hidden = false
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
    }
    
    func endActivity() {
        self.emailField.hidden = false
        self.passwordField.hidden = false
        self.loginBtn.hidden = false
        self.activityLabel.hidden = true
        self.activityIndicator.hidden = true
        self.activityIndicator.stopAnimating()
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func attemptLogin(sender: UIButton!) {
        
        if let email = emailField.text where email != "", let password = passwordField.text where password != "" {
            self.view.endEditing(true)
            startActivity("Checking with server...")
            DataService.ds.REF_BASE.authUser(email, password: password, withCompletionBlock: { error, authData in
                self.startActivity("Logging in...")
                if error != nil {
                    self.endActivity()
                    print(error)
                    if error.code == STATUS_ACCOUNT_NOEXIST {
                        self.showErrorAlert("That account does not exist", msg: "Enter a valid account.")
                    } else {
                        self.showErrorAlert("Incorrect Password", msg: "Please try again.")
                    }
                }
                
                if let data = authData {
                    let newUser = ["provider": data.provider]
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                    DataService.ds.REF_USERS.childByAppendingPath(authData.uid).setValue(newUser)
                }
    
                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
            
            })
            
        } else {
            showErrorAlert("Email and password required.", msg: "You must enter an email and password.")
        }
    }
    
    func showErrorAlert(title: String,msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}

