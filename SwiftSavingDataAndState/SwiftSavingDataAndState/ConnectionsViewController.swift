//
//  ConnectionsViewController.swift
//  SwiftSavingDataAndState
//
//  Created by George Andrews on 2/18/15.
//  Copyright (c) 2015 CVTC Mobile Developer Program. All rights reserved.
//

import UIKit
import CoreData

class ConnectionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var connectionsView: UITableView!
    
    var connections = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        connectionsView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"Connection")
        
        if let fetchedResults = try? managedContext.executeFetchRequest(fetchRequest) as? [Connection] {
            connections = fetchedResults!
        } else {
            print("Could not complete fetch.")
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connections.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        let connection = connections[indexPath.row]
        
        let firstName = connection.valueForKey("firstName")as! String?
        let lastName = connection.valueForKey("lastName") as! String?
        let emailAddress = connection.valueForKey("emailAddress") as! String?
        
        cell.textLabel!.text = "\(firstName) \(lastName) \n\(emailAddress)"
        
        return cell
    }
    
}