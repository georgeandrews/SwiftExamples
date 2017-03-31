//
//  ConnectionsViewController.swift
//  ConnectWithMe
//
//  Created by George Andrews on 3/31/17.
//  Copyright © 2017 George Andrews. All rights reserved.
//

import UIKit
import CoreData

class ConnectionsViewController: UITableViewController {
  
  var managedObjectContext: NSManagedObjectContext?
  
  var connections = [Connection]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let moc = managedObjectContext else {
      fatalError("no MOC assigned")
    }
    
    let fetchRequest: NSFetchRequest<Connection> = Connection.fetchRequest()
    
    if let results = try? moc.fetch(fetchRequest) as [Connection] {
      connections = results
      tableView.reloadData()
    }
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? SendEmailViewController {
      if let indexPath = tableView.indexPathForSelectedRow {
        destination.connection = connections[indexPath.row]
      }
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return connections.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    let connection = connections[indexPath.row]
    
    cell.textLabel?.text = "\(connection.firstName!) \(connection.lastName!) - \(connection.email!)"
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      
      guard let moc = managedObjectContext else {
        fatalError("no MOC assigned")
      }
      
      moc.delete(connections[indexPath.row])
      connections.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
  }
  
}
