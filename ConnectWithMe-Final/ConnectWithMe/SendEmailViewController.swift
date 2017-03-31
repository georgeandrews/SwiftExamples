//
//  SendEmailViewController.swift
//  ConnectWithMe
//
//  Created by George Andrews on 3/31/17.
//  Copyright © 2017 George Andrews. All rights reserved.
//

import UIKit

class SendEmailViewController: UIViewController {
  
  var connection: Connection?
  
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var messageTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let connection = connection {
      
      firstNameTextField.text = connection.firstName
      lastNameTextField.text = connection.lastName
      emailTextField.text = connection.email
      messageTextView.text = "Hello \(connection.firstName!),\r\r"
      
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    messageTextView.becomeFirstResponder()
  }
  
  @IBAction func sendMessage(_ sender: Any) {
    
    // FIXME: Implement mime email sending
    let alert = UIAlertController(title: "Not implemented!", message: "Sorry, email message sending is not yet available.", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okAction)
    
    present(alert, animated: true, completion: nil)
    
  }
  
}
