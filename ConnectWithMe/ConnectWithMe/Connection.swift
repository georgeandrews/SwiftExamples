//
//  Connection+CoreDataClass.swift
//  ConnectWithMe
//
//  Created by George Andrews on 3/31/17.
//  Copyright © 2017 George Andrews. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(Connection)
public class Connection: NSManagedObject {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Connection> {
    return NSFetchRequest<Connection>(entityName: "Connection");
  }
  
  @NSManaged public var firstName: String?
  @NSManaged public var lastName: String?
  @NSManaged public var email: String?
  
}
