//
//  ViewController.swift
//  SwiftSavingState
//
//  Created by George Andrews on 2/16/15.
//  Copyright (c) 2015 CVTC Mobile Developer Program. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.restorationIdentifier = "ConnectionController"
    }

    @IBAction func addConnection(sender: AnyObject) {
        println("Add Connection Tapped")
    }
    
    override func encodeRestorableStateWithCoder(coder: NSCoder) {
        coder.encodeObject(firstNameField.text, forKey: "firstName")
        coder.encodeObject(lastNameField.text, forKey: "lastName")
        coder.encodeObject(emailAddressField.text, forKey: "emailAddress")
        super.encodeRestorableStateWithCoder(coder)
    }
    
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        if let firstName = coder.decodeObjectForKey("firstName") as? String {
            firstNameField.text = firstName
        }
        if let lastName = coder.decodeObjectForKey("lastName") as? String {
            lastNameField.text = lastName
        }
        if let emailAddress = coder.decodeObjectForKey("emailAddress") as? String {
            emailAddressField.text = emailAddress
        }
        super.decodeRestorableStateWithCoder(coder)
    }

}

