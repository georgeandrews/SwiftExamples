//
//  ConnectionDataController.swift
//  ConnectWithMe
//
//  Created by George Andrews on 3/31/17.
//  Copyright © 2017 George Andrews. All rights reserved.
//

import Foundation
import CoreData

class CWMDataController {
  
  var mainContext: NSManagedObjectContext?
  var persistenceInitialized = false
  
  init() {
    initializeCoreDataStack()
  }
  
  func initializeCoreDataStack() {
    guard let modelURL = Bundle.main.url(forResource: "ConnectWithMe",
                                         withExtension: "momd") else {
                                          fatalError("Failed to locate DataModel.momd in app bundle")
    }
    guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
      fatalError("Failed to initialize MOM")
    }
    
    let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
    
    let type = NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType
    mainContext = NSManagedObjectContext(concurrencyType: type)
    mainContext?.persistentStoreCoordinator = psc
    
    let queue = DispatchQueue.global(qos: .background)
    queue.async {
      let fileManager = FileManager.default
      guard let documentsURL = fileManager.urls(for: .documentDirectory,
                                                in: .userDomainMask).first else {
                                                  fatalError("Failed to resolve documents directory")
      }
      let storeURL = documentsURL.appendingPathComponent("ConnectWithMe.sqlite")
      
      do {
        try psc.addPersistentStore(ofType: NSSQLiteStoreType,
                                   configurationName: nil, at: storeURL, options: nil)
      } catch {
        fatalError("Failed to initialize PSC: \(error)")
      }
      
      self.persistenceInitialized = true
    }
  }
  
  func saveContext() {
    guard let main = mainContext else {
      fatalError("save called before mainContext is initialized")
    }
    main.performAndWait({
      if !main.hasChanges { return }
      do {
        try main.save()
      } catch {
        fatalError("Failed to save mainContext: \(error)")
      }
    })
  }
  
}
