//
//  SettingsViewController.swift
//  iMoz
//
//  Created by George Andrews on 4/9/15.
//  Copyright (c) 2015 George Andrews. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var accessIDTextField: UITextField!
    @IBOutlet weak var secretKeyTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.restorationIdentifier = "Settings"
        
        accessIDTextField.delegate = self
        secretKeyTextField.delegate = self
        
        // 1. Display correct button title
        if NSUserDefaults.standardUserDefaults().boolForKey("hasCredentials") == false {
            saveButton.setTitle("Save", forState: .Normal)
        } else {
            accessIDTextField.text = NSUserDefaults.standardUserDefaults().valueForKey("accessID") as? String
            secretKeyTextField.text = NSUserDefaults.standardUserDefaults().valueForKey("secretKey") as? String
            saveButton.setTitle("Update", forState: .Normal)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveConfig(sender: AnyObject) {
        
        // 1. Validate inputs
        if (accessIDTextField.text == "" || secretKeyTextField.text == "") {
            var alert = UIAlertView()
            alert.title = "You must enter both an access id and a secret key!"
            alert.addButtonWithTitle("Oops!")
            alert.show()
            return;
        }
        
        // 2. Dismiss keyboard
        accessIDTextField.resignFirstResponder()
        secretKeyTextField.resignFirstResponder()
        
        // 3. Save access id and secret key
        NSUserDefaults.standardUserDefaults().setValue(self.accessIDTextField.text, forKey: "accessID")
        NSUserDefaults.standardUserDefaults().setValue(self.secretKeyTextField.text, forKey: "secretKey")
        
        // 4. Update button state for settings view
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasCredentials")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        saveButton.setTitle("Update", forState: .Normal)

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    override func encodeRestorableStateWithCoder(coder: NSCoder) {
        coder.encodeObject(accessIDTextField.text, forKey: "accessID")
        coder.encodeObject(secretKeyTextField.text, forKey: "secretKey")
        super.encodeRestorableStateWithCoder(coder)
    }
    
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        if let accessID = coder.decodeObjectForKey("accessID") as? String {
            accessIDTextField.text = accessID
        }
        if let secretKey = coder.decodeObjectForKey("secretKey") as? String {
            secretKeyTextField.text = secretKey
        }
        super.decodeRestorableStateWithCoder(coder)
    }


}

