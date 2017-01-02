//
//  ViewController.swift
//  SwiftPedometer
//
//  Created by George Andrews on 2/5/15.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    let pedometer = CMPedometer()
    var data: CMPedometerData?
    
    @IBOutlet weak var stepsCounter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Calendar.current.startOfDay(for: Date())) {
                (data, error) -> Void in
                if error != nil {
                    print("Error: \(error)")
                } else {
                    DispatchQueue.main.async(execute: {
                        self.stepsCounter.text = "\(data!.numberOfSteps)"
                    });
                }
            }
            
        } else {
            print("WARNING: Step counting is not available on this device.")
        }
        
    }

}

