//
//  MozDataViewController.swift
//  iMoz
//
//  Created by George Andrews on 7/23/15.
//  Copyright (c) 2015 George Andrews. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UITableViewController, UITableViewDataSource {
    
    @IBOutlet var mozDataView: UITableView!
    
    var mozData: MozData?
    
    var mozArray: NSArray? = [NSString]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mozDataView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        mozDataView.dataSource = self
        
        self.mozArray = ResponseField.stringValues
        
    }
    
    // MARK: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mozArray!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.mozDataView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        // 1. Retrieve mozData key/value pair
        var key: AnyObject? = mozArray?.objectAtIndex(indexPath.row)
        var value: AnyObject? = mozData?.valueForKey(key! as! String)
        
        key = UrlMetrics.responseFields[key as! String]
        
        populateCell(cell, key: key, value: value)
        
        return cell
    }
    
    func populateCell(cell: UITableViewCell, key: AnyObject?, value: AnyObject?) {
        if let valueString = value as? String {
            cell.textLabel!.text = "\(key as! String): \(valueString)"
        } else if let valueNumber = value as? NSNumber {
            cell.textLabel!.text = "\(key as! String): \(valueNumber.stringValue)"
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        mozDataView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
    }
    
}
