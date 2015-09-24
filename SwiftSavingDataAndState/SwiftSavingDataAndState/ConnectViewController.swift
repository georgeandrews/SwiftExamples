//
//  ViewController.swift
//  SwiftSavingDataAndState
//
//  Created by George Andrews on 2/15/15.
//  Copyright (c) 2015 CVTC Mobile Developer Program. All rights reserved.
//

import UIKit
import CoreData

class ConnectViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.restorationIdentifier = "ConnectionController"
    }
    
    @IBAction func addConnection(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entityForName("Connection", inManagedObjectContext: managedContext)
        let connection = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        connection.setValue(firstNameTextField.text, forKey: "firstName")
        connection.setValue(lastNameTextField.text, forKey: "lastName")
        connection.setValue(emailAddressTextField.text, forKey: "emailAddress")
        
        var error: NSError?
        if (!managedContext.save(&error)) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
    
    override func encodeRestorableStateWithCoder(coder: NSCoder) {
        coder.encodeObject(firstNameTextField.text, forKey: "firstName")
        coder.encodeObject(lastNameTextField.text, forKey: "lastName")
        coder.encodeObject(emailAddressTextField.text, forKey: "emailAddress")
        super.encodeRestorableStateWithCoder(coder)
    }
    
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        if let firstName = coder.decodeObjectForKey("firstName") as? String {
            firstNameTextField.text = firstName
        }
        if let lastName = coder.decodeObjectForKey("lastName") as? String {
            lastNameTextField.text = lastName
        }
        if let emailAddress = coder.decodeObjectForKey("emailAddress") as? String {
            emailAddressTextField.text = emailAddress
        }
        super.decodeRestorableStateWithCoder(coder)
    }

}
