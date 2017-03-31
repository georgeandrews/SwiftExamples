
//
//  ViewController.swift
//  ConnectWithMe
//
//  Created by George Andrews on 3/31/17.
//  Copyright © 2017 George Andrews. All rights reserved.
//

import UIKit
import CoreData

class ConnectViewController: UIViewController {
  
  var managedObjectContext: NSManagedObjectContext?

  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? ConnectionsViewController {
      destination.managedObjectContext = managedObjectContext
    }
  }

  @IBAction func saveConnection(_ sender: Any) {

    if firstNameTextField.hasText, lastNameTextField.hasText, emailTextField.hasText, isValidEmail(emailTextField.text) {
      
      let firstName = firstNameTextField.text
      let lastName = lastNameTextField.text
      let email = emailTextField.text
      
      guard let moc = managedObjectContext else {
        fatalError("MOC not initialized")
      }
      
      guard let entity = NSEntityDescription.entity(forEntityName: "Connection", in: moc) else {
        return
      }
      
      let connection = Connection(entity: entity, insertInto: moc)
      connection.firstName = firstName
      connection.lastName = lastName
      connection.email = email
      
      do {
        
        try moc.save()
        
        let alert = UIAlertController(title: "Connection saved!", message: "Thanks for connecting with me :]", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
      } catch let error as NSError {
        
        let alert = UIAlertController(title: "Core Data issue!", message: "Sorry, there was a problem saving your data.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
        print("Could not save \(error), \(error.userInfo)") // FIXME: Remove before shipping
      }
      
    } else {
      let alert = UIAlertController(title: "Invalid form data!", message: "Sorry, you must complete all fields appropriately.", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alert.addAction(okAction)
      
      present(alert, animated: true, completion: nil)
    }
    
  }
  
  func isValidEmail(_ email: String?) -> Bool {
    // TODO: Validate email
    return true
  }
  
  override func encodeRestorableState(with coder: NSCoder) {
    coder.encode(firstNameTextField.text, forKey: "firstName")
    coder.encode(lastNameTextField.text, forKey: "lastName")
    coder.encode(emailTextField.text, forKey: "email")
    super.encodeRestorableState(with: coder)
  }
  
  override func decodeRestorableState(with coder: NSCoder) {
    if let firstName = coder.decodeObject(forKey: "firstName") as? String {
      firstNameTextField.text = firstName
    }
    if let lastName = coder.decodeObject(forKey: "lastName") as? String {
      lastNameTextField.text = lastName
    }
    if let email = coder.decodeObject(forKey: "email") as? String {
      emailTextField.text = email
    }
    super.decodeRestorableState(with: coder)
  }

}

