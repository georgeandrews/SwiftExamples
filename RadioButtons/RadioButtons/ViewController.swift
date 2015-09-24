//
//  ViewController.swift
//  RadioButtons
//
//  Created by George Andrews on 4/6/15.
//  Copyright (c) 2015 CVTC Mobile Developer Program. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let items = ["miles", "kilometers"]
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var convertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.dataSource = self
        picker.delegate = self
        
        convertButton.layer.cornerRadius = 3
        convertButton.layer.borderWidth = 1
        convertButton.layer.borderColor = UIColor.brownColor().CGColor
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return items[row]
    }

}

