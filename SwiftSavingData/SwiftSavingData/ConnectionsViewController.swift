//
//  ConnectionsViewController.swift
//  SwiftSavingData
//
//  Created by George Andrews on 2/19/15.
//  Copyright (c) 2015 CVTC Mobile Developer Program. All rights reserved.
//

import UIKit
import CoreData

class ConnectionsViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var connections = [NSManagedObject]()
    
    @IBOutlet weak var connectionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectionsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

        let fetchRequest = NSFetchRequest(entityName:"Connection")
        
        var error: NSError?
        if let fetchedResults = appDelegate.managedObjectContext!.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject] {
            connections = fetchedResults
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        connectionsTableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connections.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
            
        let connection = connections[indexPath.row]
            
        let firstName: String = connection.valueForKey("firstName") as String
        let lastName: String = connection.valueForKey("lastName") as String
        let emailAddress: String = connection.valueForKey("emailAddress") as String
            
        cell.textLabel!.text = "\(firstName) \(lastName), \(emailAddress)"
            
        return cell
        
    }
    
}
