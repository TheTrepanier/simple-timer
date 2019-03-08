//
//  SetTimeViewController.swift
//  Simple Timer
//
//  Created by Michael Scott Trepanier on 10/3/18.
//  Copyright © 2018 Michael Scott Trepanier. All rights reserved.
//

import UIKit

protocol SetTimeDelegate {
    func userSetTime(seconds: Int)
}

class SetTimeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var delegat: SetTimeDelegate?
    let timeArray = Array(0...59)
    
    @IBOutlet var setTimeField: UITextField!
    let timePicker = UIPickerView()
    
    override func viewDidLoad() {
        setTimeField.inputView = timePicker
        
        self.timePicker.dataSource = self
        self.timePicker.delegate = self
        
        self.setTimeField.inputView = self.timePicker
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(timeArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let minutes = timeArray[pickerView.selectedRow(inComponent: 0)]
        let seconds = timeArray[pickerView.selectedRow(inComponent: 1)]
        
        setTimeField.text = "\(minutes * 60 + seconds)"
    }
    
    func openTimePicker() {
        timePicker.frame = CGRect(x: 0.0, y: (self.view.frame.height/2 + 60), width: self.view.frame.width, height: 150.0)
        timePicker.backgroundColor = UIColor.white
        self.view.addSubview(timePicker)
    }
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        if setTimeField.text != "" {
            let userTimeEntered = Int(setTimeField.text!)
            delegat?.userSetTime(seconds: userTimeEntered!)
            self.dismiss(animated: true, completion: nil)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
