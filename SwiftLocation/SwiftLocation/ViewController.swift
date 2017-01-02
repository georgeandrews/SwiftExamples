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
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    @IBAction func findWaldo(_ sender: AnyObject) {
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) -> Void in
            
            if let placemarks = placemarks {
                if placemarks.count > 0 {
                    self.displayLocation(placemarks[0])
                }
            } else {
                print("Error: \(error)")
            }
            
        }
    }
    
    func displayLocation(_ placemark: CLPlacemark?) {
        locationManager.stopUpdatingLocation()
        let postalCode = (placemark?.postalCode != nil) ? placemark?.postalCode : "UNKNOWN"
        self.locationLabel.text = postalCode
    }
    
}

