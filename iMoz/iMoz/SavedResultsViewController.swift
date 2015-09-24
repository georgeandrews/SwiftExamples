//
//  SavedResultsViewController.swift
//  iMoz
//
//  Created by George Andrews on 4/9/15.
//  Copyright (c) 2015 George Andrews. All rights reserved.
//

import UIKit
import CoreData

class SavedResultsViewController: UITableViewController, UITableViewDataSource {
    
    @IBOutlet var mozDataView: UITableView!
    
    var mozDatas = [MozData]()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // 1. Check for credentials
        if NSUserDefaults.standardUserDefaults().boolForKey("hasCredentials") == false {
            // 2. No credentials, show Settings View Controller
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mozDataView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        mozDataView.dataSource = self
        

    }
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"MozData")
        
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [MozData]
        if let results = fetchedResults {
            mozDatas = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        mozDataView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        // 1. Check for credentials
        if NSUserDefaults.standardUserDefaults().boolForKey("hasCredentials") == false {
            // 2. No credentials, show Settings View Controller
            self.tabBarController?.selectedIndex = 2
        }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow() {
            tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? DetailViewController {
            if let indexPath = tableView.indexPathsForSelectedRows()?.first as? NSIndexPath {
                destination.mozData = mozDatas[indexPath.row]
            }
        }
    }
    
    // MARK: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mozDatas.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let mozData = mozDatas[indexPath.row]
        
        let cell = self.mozDataView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel!.text = mozData.canonicalURL
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("showMozData", sender: indexPath)
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext!
            managedContext.deleteObject(mozDatas[indexPath.row] as MozData)
            managedContext.save(nil)
            
            mozDatas.removeAtIndex(indexPath.row)
            mozDataView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
}