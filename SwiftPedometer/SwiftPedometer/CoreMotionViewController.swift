//
//  CoreMotionViewController.swift
//  SwiftPedometer
//
//  Created by George Andrews on 9/21/15.
//  Copyright © 2015 CVTC Mobile Developer Program. All rights reserved.
//

import UIKit
import CoreMotion

class CoreMotionViewController: UIViewController {
    
    @IBOutlet weak var coordsLabel: UILabel!
    
    let manager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 1
            manager.startDeviceMotionUpdates(to: OperationQueue.main) {
                (data, error) in
                if error != nil {
                    print("Error: \(error)")
                } else {
                    self.coordsLabel.text = "X: \(data!.gravity.x); Y: \(data!.gravity.y); Z:\(data!.gravity.z)"
                }

            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        manager.stopGyroUpdates()
    }
    
}
