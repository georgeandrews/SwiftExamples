//
//  SearchViewController.swift
//  iMoz
//
//  Created by George Andrews on 4/11/15.
//  Copyright (c) George Andrews. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var accessID: String?
    var secretKey: String?
    
    var mozArray: NSArray? = ResponseField.stringValues
    var mozJSONDictionary: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.restorationIdentifier = "Search"
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        searchBar.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // 1. Check for credentials
        if NSUserDefaults.standardUserDefaults().boolForKey("hasCredentials") == false {
            // 2. No credentials, show Settings View Controller
            self.tabBarController?.selectedIndex = 2
        } else {
            // 3. Set credentials
            accessID = NSUserDefaults.standardUserDefaults().valueForKey("accessID") as? String
            secretKey = NSUserDefaults.standardUserDefaults().valueForKey("secretKey") as? String
        }
    }

    func getMozData(searchURL: String) {
        
        // 1. Create mozScape object with credentials and URL to lookup
        let mozScape = Mozscape(searchURL: searchURL, accessID: accessID!, secretKey: secretKey!)
        
        // 2. Perform lookup
        mozScape.getMozDataFromAPIRequest { (mozJSON) -> Void in
            
            if let mozJSON = mozJSON {
                
                // FIXME: Remove log statement prior to shipping
                println(NSString(data: mozJSON, encoding: NSUTF8StringEncoding) as! String)
                
                // 3. Use Dictionary to hold key/value pairs
                if let jsonDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(mozJSON, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
                    
                    // 4. Use String array to hold Dictionary keys for each matching ResponseField enum value
                    self.mozJSONDictionary = jsonDictionary
                    
                    // Important: send reloadData message on the main thread
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                        self.searchBar.hidden = false
                        self.activityIndicator.stopAnimating()
                    }
                    
                }
            }
            
        }
        
    }

    
    @IBAction func saveMozData(sender: AnyObject) {
        
        if nil == mozJSONDictionary {
            var alert = UIAlertView()
            alert.title = "You must first perform a lookup!"
            alert.addButtonWithTitle("Okay")
            alert.show()
            return;
        }
        
        print(mozJSONDictionary)
        
        // 1. Create MozData managed object
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let mozData = NSEntityDescription.insertNewObjectForEntityForName("MozData", inManagedObjectContext: managedContext) as! MozData
        
        // 3. Set managed object's attributes
        mozData.canonicalURL = mozJSONDictionary?.valueForKey(ResponseField.uu.rawValue as String) as! String
        mozData.mozRank = mozJSONDictionary?.valueForKey(ResponseField.umrp.rawValue as String) as! NSNumber
        mozData.mozTrust = mozJSONDictionary?.valueForKey(ResponseField.utrp.rawValue as String) as! NSNumber
        mozData.mozSpam = mozJSONDictionary?.valueForKey(ResponseField.fspsc.rawValue as String) as! NSNumber
        mozData.pageAuthority = mozJSONDictionary?.valueForKey(ResponseField.upa.rawValue as String) as! NSNumber
        mozData.domainAuthority = mozJSONDictionary?.valueForKey(ResponseField.pda.rawValue as String) as! NSNumber
        mozData.externalLinks = mozJSONDictionary?.valueForKey(ResponseField.ueid.rawValue as String) as! NSNumber
        
        // 4. Save managed object to Core Data store
      try managedContext.save()
      catch 
//        var error: NSError?
//        if managedContext.save() {
//            print("Could not save \(error), \(error?.userInfo)")
//        }
      
    }
    
    override func encodeRestorableStateWithCoder(coder: NSCoder) {
        coder.encodeObject(searchBar.text, forKey: "searchValue")
        super.encodeRestorableStateWithCoder(coder)
    }
    
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        if let searchValue = coder.decodeObjectForKey("searchValue") as? String {
            searchBar.text = searchValue
        }
        super.decodeRestorableStateWithCoder(coder)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.hidden = true
        activityIndicator.startAnimating()
        
        // 1. Validate URL
        if (searchBar.text == "" || !UIApplication.sharedApplication().canOpenURL(NSURL(string: searchBar.text)!)) {
            var alert = UIAlertView()
            alert.title = "You must enter a well-formed URL to perform a lookup!"
            alert.addButtonWithTitle("Okay")
            alert.show()
            
            searchBar.hidden = false
            activityIndicator.stopAnimating()
            return;
        }
        
        // 2. Perform lookup
        getMozData(searchBar.text)
        
        self.searchBar.hidden = false
        self.activityIndicator.stopAnimating()
    }
    
}


extension SearchViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mozArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        // 1. Retrieve mozData key/value pair
        var key: AnyObject? = mozArray?.objectAtIndex(indexPath.row)
        var value: AnyObject? = mozJSONDictionary?.valueForKey(key! as! String)
        
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

}
