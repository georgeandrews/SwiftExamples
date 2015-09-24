//
//  MozData.swift
//  iMoz
//
//  Created by George Andrews on 4/9/15.
//  Copyright (c) 2015 George Andrews. All rights reserved.
//

import CoreData

class MozData: NSManagedObject {

    @NSManaged var canonicalURL: String
    @NSManaged var domainAuthority: NSNumber
    @NSManaged var externalLinks: NSNumber
    @NSManaged var mozRank: NSNumber
    @NSManaged var mozTrust: NSNumber
    @NSManaged var mozSpam: NSNumber
    @NSManaged var pageAuthority: NSNumber
    
    override func valueForKey(key: String) -> AnyObject? {
        switch key {
        case ResponseField.fspsc.rawValue:
            return mozSpam
        case ResponseField.pda.rawValue:
            return domainAuthority
        case ResponseField.ueid.rawValue:
            return externalLinks
        case ResponseField.umrp.rawValue:
            return mozRank
        case ResponseField.upa.rawValue:
            return pageAuthority
        case ResponseField.utrp.rawValue:
            return mozTrust
        case ResponseField.uu.rawValue:
            return canonicalURL
        default:
            return nil
        }
    }
    
}
