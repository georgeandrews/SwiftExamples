//
//  ViewController.swift
//  SwiftLocation
//
//  Created by Andrews Jr, George on 2/10/15.
//  Copyright (c) 2015 Andrews Jr, George. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func findWaldo(sender: AnyObject) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.Authorized {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        // location updated
        CLGeocoder().reverseGeocodeLocation(manager.location) {
            (placemarks, error) -> Void in
            if (error != nil) {
                println("Error: \(error)")
            } else {
                if placemarks.count > 0 {
                    if let pm = placemarks[0] as? CLPlacemark {
                        self.displayLocation(pm)
                    }
                }
            }
        
        }
    }
    
    func displayLocation(placemark: CLPlacemark?) {
        locationManager.stopUpdatingLocation()
        let postalCode = (placemark?.postalCode != nil) ? placemark?.postalCode : "00000"
        self.locationLabel.text = postalCode
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }
}

