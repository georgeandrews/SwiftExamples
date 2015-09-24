//
//  Connection.swift
//  SwiftSavingDataAndState
//
//  Created by George Andrews on 2/16/15.
//  Copyright (c) 2015 CVTC Mobile Developer Program. All rights reserved.
//

import Foundation
import CoreData

@objc(Connection)
class Connection: NSManagedObject {

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var emailAddress: String

}
